#== ABOUT --------------------------------------------------------------------------------------------------------------;

    FUNCTION: create_time_flow_template
    AUTHOR: Walter Levy
    DATE: 2023-07-03

    DESCRIPTION ----------------------------------------------------------------------------------------------------

        Creates a time-flow template with a given frequency. A time-flow template contains a from_date and a date_
        where from_date is equal to the previous date_. It is used for data containing flow-variables like return
        and various pnl:s.

        Custom dates will only be considered if between start_date and end_date.

        The first from_date will be equal to start_date and the last date_ will be equal to end_date (assuming they
        do not fall on a weekend).

        Use freq_unit = NONE to use only the custom date framework, i.e. to produce a template containing only
        custom dates.

        Whatever date rule is in use, the created template will always be on business dates.

        Todo: Deal with custom_date_df empty dataframe

    INPUT ----------------------------------------------------------------------------------------------------------

        create_time_flow_template(
          * start_date =,              example: 2018-12-31
          * end_date =,

            freq = 1,                  frequency value, values: {1,}
            freq_unit = D,             frequency unit, values: D|W|M|NONE (workdays|weeks|months|NULL)
            date_rule = FBD,           when freq_unit = M: values: FBD|{1,31}
                                       when freq_unit = W: values: FBD|MON|TUE|WED|THU|FRI
                                           (FBD = first business date after start_date)
            custom_date_df =,          custom dates that must be part of time-flow template
            custom_by_vars =,          variables in <custom_date_df>
        );

          * = mandatory

        ------------------------------------------------------------------------------------------------------------

        DATAFRAME: <custom_date_df>
            (<custom_by_vars>)
            date_

    OUTPUT ---------------------------------------------------------------------------------------------------------

        DATAFRAME:
            (<custom_by_vars>)
            from_date
            date_

### DEPENDENCIES -----------------------------------------------------------------------------------------------------=#

    using DataFrames, ShiftedArrays, DateFunctions

### FUNCTION ----------------------------------------------------------------------------------------------------------;

function create_time_flow_template(
    ;
    start_date::Union{Dates.Date, Missing} = missing,
    end_date::Union{Dates.Date, Missing} = missing,

    freq::Int = 1,
    freq_unit::String = "D",
    date_rule::String = "FBD",

    custom_date_df::DataFrame = DataFrame(),
    custom_by_vars::Union{String, Missing} = missing
)

### CREATE TIME-PERIOD -------------------------------------------------------------------------------------------------

    # Making sure start and end date are both business dates
    loc_start_date = current_business_date(start_date)
    loc_end_date = last_business_date(end_date)

### CREATE TIME-FLOW TEMPLATE ------------------------------------------------------------------------------------------

    return_df = DataFrame()
    if freq_unit == "D"
        length = freq
        for loop_date = loc_start_date:Dates.Day(1):loc_end_date
            if is_business_date(loop_date)
                from_date = loop_date
                date_ = add_n_business_dates(loop_date, n = freq)
                if length == freq && from_date < loc_end_date
                    push!(return_df,
                        (
                            from_date = from_date,
                            date_ = date_
                        )
                    )
                    length = 1
                else
                    length = length + 1
                end
            end
        end
    elseif freq_unit == "W"
        length = freq
        # Create weekday
        if date_rule == "FBD"
            weekday = dayofweek(loc_start_date)
        elseif date_rule == "MON"
            weekday = 1
        elseif date_rule == "TUE"
            weekday = 2
        elseif date_rule == "WED"
            weekday = 3
        elseif date_rule == "THU"
            weekday = 4
        elseif date_rule == "FRI"
            weekday = 5
        end
        for loop_date = loc_start_date:Dates.Day(1):loc_end_date
            if dayofweek(loop_date) == weekday
                from_date = loop_date
                date_ = from_date + freq * Dates.Day(7)
                if length == freq && from_date < loc_end_date
                    push!(return_df,
                        (
                            from_date = from_date,
                            date_ = date_
                        )
                    )
                    length = 1
                else
                    length = length + 1
                end
            end
        end
    elseif freq_unit == "M"
        length = freq
        #Looping through months, always on the first of the month for predictability
        for loop_date = firstdayofmonth(loc_start_date):Dates.Month(1):firstdayofmonth(loc_end_date)
            if date_rule == "FBD"
                day_of_month = dayofmonth(loc_start_date)
            else
                day_of_month = parse(Int, date_rule)
            end
            # Guessing I want the last business day of the month
            from_date = last_business_date(lastdayofmonth(loop_date))
            # Modify guess if we needed an earlier (business) date that month
            if day_of_month < dayofmonth(from_date)
                from_date = last_business_date(Dates.Date(year(from_date), month(from_date), day_of_month))
            end

            # Guessing I want the last business day of the month also for the date_
            date_ = last_business_date(lastdayofmonth(loop_date + Month(freq)))

            # Modify guess if we needed an earlier (business) date that month
            if day_of_month < dayofmonth(date_)
                date_ = last_business_date(Dates.Date(year(date_), month(date_), day_of_month))
            end

            # Check if within time-period
            if loc_start_date <= from_date < loc_end_date
                # Check if right length
                if length == freq
                    push!(return_df,
                        (
                            from_date = from_date,
                            date_ = date_
                        )
                    )
                    length = 1
                else
                    length = length + 1
                end
            end
        end
    elseif freq_unit == "NONE"
        push!(return_df,
            (
                from_date = loc_start_date,
                date_ = loc_end_date
            )
        )
    else
        println("This usage not allowed in this prison, freq_unit = ", freq_unit)
    end

    # Selecting distinct from_date:s from above
    original_from_date_df = select(unique(return_df, [:from_date]), :from_date)
    # Adding loc_start_date and loc_end_date to the list of from_date:s to keep.
    always_from_date_df = DataFrame(from_date = [loc_start_date, loc_end_date])
    # Renaming inputted dates to from_date.
    if nrow(custom_date_df) > 0
        custom_from_date_df = select(custom_date_df, :date_ => :from_date)
    else
        custom_from_date_df = DataFrame(from_date = Date[])
    end
    # Stacking the 3 dataframes of from_date:s
    return_df2 = vcat(original_from_date_df, always_from_date_df, custom_from_date_df)
    # Making sure the from_date:s are unique and sorted
    return_df3 = sort(unique(return_df2, [:from_date]), :from_date)
    # Keeping only business dates
    return_df4 = return_df3[is_business_date.(return_df3.from_date), :]

    # Creating date_ purely from from_date as the next value
    return_df5 = combine(return_df4,
        :from_date,
        :from_date => ((from_date) -> ShiftedArrays.lead(from_date, 1)) => :date_
    )
    # Getting rid of the last observation when date_ is missing due to the lead operation
    return_df6 = filter(
        :date_ => !ismissing
        #:date_ => (date_ -> !ismissing.(date_))
    , return_df5)

    return return_df6

end

#= TEST ----------------------------------------------------------------------------------------------------------------

    # Creating a dataframe with some custum dates
    my_custom_dates_df = DataFrame(
        date_ = [
            Date(2021, 04, 28),
            Date(2021, 05, 04)
        ]
    )


    time_flow_template = create_time_flow_template(
        start_date = Date(2020, 12, 31),
        end_date = Date(2021, 06, 29),

        custom_date_df = my_custom_dates_df,

        freq = 1,
        freq_unit = "W",
        date_rule = "FBD"
    )

    time_flow_template2 = create_time_flow_template(
        start_date = Date(2021, 05, 04),
        end_date = Date(2022, 05, 11),
        #freq = 1,
        freq_unit = "M",
        date_rule = "FBD",
    )

### ------------------------------------------------------------------------------------------------------------------=#

