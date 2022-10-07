### A Pluto.jl notebook ###
# v0.19.3

using Markdown
using InteractiveUtils

# ╔═╡ 13b5fb20-4668-11ed-2137-d16045006353
md"# Pluto $\LaTeX$ cheat sheet"

# ╔═╡ 310319ff-15ed-429a-a7d8-d475399b1856
md"## Basic Syntax"

# ╔═╡ 7c23dab5-97c1-4e7b-8f5c-f7d5f1e9ac1d
md"
* Text Mode vs. Math Mode
* \$\$ for Math Mode
* Inline vs Display
* \ for symbols and function
* {} used with functions
* Whitespace is important
"

# ╔═╡ 9b2364b1-c4ad-49dd-aa4f-2c0cb22a3406
md"This is Text Mode."

# ╔═╡ 5db299a4-6742-4e8f-8cca-94155479157a
md"$This is what text looks like inside of Math Mode.$"

# ╔═╡ 118f128a-0821-43d2-b246-b96ecfeb009f
md"$\text{This is how to display text inside Math Mode.}$"

# ╔═╡ 5aa9f254-5df6-455a-a8f1-65ba1f6c68df
md" Text mode: 1 + 1 = 2"

# ╔═╡ 1693be7e-9b19-439a-ab2d-59672b6b94ba
md" Math mode: $1+1=2$"

# ╔═╡ 5c1e6aef-0113-4860-968c-ca9914df3ea4
md"$1+1=2$"

# ╔═╡ c227fa89-d5ce-4312-bf27-d052551eb476
md"special treatment of certain letters $1 + 2 \times 3 \div 4 x 5$"

# ╔═╡ f49767af-5cac-46ec-b8f1-54bb719d5932
md"$\frac{3}{\sqrt{16}}=0.75$"

# ╔═╡ 8a02c3bd-7264-4b76-a000-ddcc45a689a0
md"subscripts and super"

# ╔═╡ a0a155a0-9486-437e-82d7-e14da57c5e72
md"$t_0 = x^2$"

# ╔═╡ fedd02eb-f0d8-40f8-ab24-b5c0bf046569
md"Multiline math"

# ╔═╡ 46b44823-1611-4dbf-84f3-4efcd8e3099c
md"$\begin{gather}
this is one line of text \\
\text{and this is another line of text}
\end{gather}$"

# ╔═╡ 9d45cf15-1b15-4610-bb2d-73a9672e8e50
md"## Example Equtions"

# ╔═╡ dad5d70f-631f-4393-b2c3-b3c8d3595e41
md"$a^2 + b^2 = c^2$"

# ╔═╡ 2e4466e4-6051-4175-a687-a1ae3a5a7f72
md"$A = \pi r^2$"

# ╔═╡ 52291af1-8956-4cde-a9ab-6f329bb48809
md"\alpha<Tab> displays as α and \degree<Tab> as °"

# ╔═╡ d0998397-5e6a-495d-9b3d-cc82f63d122a
md"$α °$"

# ╔═╡ 5553cd23-7b54-47c3-839a-5a2896cc1069
md"$x y z$"

# ╔═╡ 00d025d8-5ab8-4754-8cd6-f94d40cc8422
md"$x /space y /space z $"

# ╔═╡ 8b471bc7-908d-472f-a1b8-2adb3d872c48


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╠═13b5fb20-4668-11ed-2137-d16045006353
# ╠═310319ff-15ed-429a-a7d8-d475399b1856
# ╠═7c23dab5-97c1-4e7b-8f5c-f7d5f1e9ac1d
# ╠═9b2364b1-c4ad-49dd-aa4f-2c0cb22a3406
# ╠═5db299a4-6742-4e8f-8cca-94155479157a
# ╠═118f128a-0821-43d2-b246-b96ecfeb009f
# ╠═5aa9f254-5df6-455a-a8f1-65ba1f6c68df
# ╠═1693be7e-9b19-439a-ab2d-59672b6b94ba
# ╠═5c1e6aef-0113-4860-968c-ca9914df3ea4
# ╠═c227fa89-d5ce-4312-bf27-d052551eb476
# ╠═f49767af-5cac-46ec-b8f1-54bb719d5932
# ╠═8a02c3bd-7264-4b76-a000-ddcc45a689a0
# ╠═a0a155a0-9486-437e-82d7-e14da57c5e72
# ╠═fedd02eb-f0d8-40f8-ab24-b5c0bf046569
# ╠═46b44823-1611-4dbf-84f3-4efcd8e3099c
# ╠═9d45cf15-1b15-4610-bb2d-73a9672e8e50
# ╠═dad5d70f-631f-4393-b2c3-b3c8d3595e41
# ╠═2e4466e4-6051-4175-a687-a1ae3a5a7f72
# ╠═52291af1-8956-4cde-a9ab-6f329bb48809
# ╠═d0998397-5e6a-495d-9b3d-cc82f63d122a
# ╠═5553cd23-7b54-47c3-839a-5a2896cc1069
# ╠═00d025d8-5ab8-4754-8cd6-f94d40cc8422
# ╠═8b471bc7-908d-472f-a1b8-2adb3d872c48
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
