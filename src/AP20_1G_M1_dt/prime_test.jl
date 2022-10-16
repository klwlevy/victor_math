using Primes, DataFrames, Plots

prime_df = DataFrame(prime_number = Primes.primes(100, 300))

prime_df.row_no = 1:nrow(prime_df)

p = plot(prime_df.prime_number)

tableskill(
    dataframe_dict = Dict(
        "prime_df" => prime_df,
    )
)

