# Recontextualization Corpus

A corpus of views and structure-returning operations together with
recontextualizations along them


## Naproche

Naproche allows to parse ForTheL documents and print the results in a
"naïvely informalized" format which can then be "polished" by applying
the rewriting rules we use for recontextualization.

To generate this corpus, run the script `naproche.sh`:

```
naproche.sh <path to Naproche executable> <path to Naproche's math directory> <output directory>
```

This will gather all files in Naproche's `math` directory whose file name
extension is either `.ftl`, `.ftl.tex` or `.ftl.en.tex` and generates a
corresponding `.txt` file in one of the subdirectories of the `naproche`
directory in this repository.
Note that this script overwrites already existing `.txt` files in the
`naproche` directory!

**Currently, this only works with the Naproche version provided via the
[`McEarl/naproche:informalization`](https://github.com/McEarl/naproche/tree/informalization)
branch of the Naproche repository.**

