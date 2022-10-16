using Latexify

my_latex_str = latexify("exp(-x) / 3")

test_df = DataFrame(test = my_latex_str)
# Unfortunately, REPL cannot render a LaTeXString, but this is a workaround
render(my_latex_str)

numbers_to_sort = [1.3, 7//10, 9//8]
names = ["1.3", "7/10", "9/8"]

using DataFrames
df = DataFrame(numbers_to_sort = [1.3, 7//10, 9//8], names = ["1.3", "7/10", "9/8"])
# Can do this, but Unfortunately it can't be rendered.
# The returned object is not a dataframe anymore but a Markdown object
latex_df_md = latexify(df)

tableskill(
    dataframe_dict = Dict(
        "df" => df,
        "test_df" => test_df,
    )
)

