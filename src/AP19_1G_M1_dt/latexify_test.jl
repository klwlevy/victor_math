using Latexify

my_latex_str = latexify("exp(-x) / 3")

# Unfortunately, REPL cannot render a LaTeXString, but this is a workaround
render(my_latex_str)

numbers_to_sort = [1.3, 7//10, 9//8]
names = ["1.3", "7/10", "9/8"]

using DataFrames
df = DataFrame(numbers_to_sort = [1.3, 7//10, 9//8], names = ["1.3", "7/10", "9/8"])
# Can do this, but Unfortunately it can't be rendered
latex_df = latexify(df)
