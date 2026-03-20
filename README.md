# Recontextualization Corpus

A corpus of views and structure-returning operations together with
recontextualizations along them


## Naproche

Naproche allows to parse ForTheL documents and print the results in a
"naïvely informalized" format which can then be "polished" by applying
the rewriting rules we use for recontextualization.

**Currently, this only works with the Naproche version provided by the
[`McEarl/naproche:informalization`](https://github.com/McEarl/naproche/tree/informalization)
branch of the Naproche repository.**

To generate this corpus, run the script `naproche.sh`:

```
naproche.sh <path to Naproche executable> <path to Naproche's math directory> <output directory>
```

This will gather all files in Naproche's `math` directory whose file name
extension is either `.ftl`, `.ftl.tex` or `.ftl.en.tex` and generates
corresponding `.doc` and `.lex` files in the `naproche/ftl`, `naproche/tex`
and `naproche/stex` directories, resp., in this repository.
The `.doc` file contains the "naïvely informalized" version of the parsing
result; the `.lex` file contains the lexicon that Naproche generates
during parsing.

Note that this script overwrites already existing `.doc` and `.lex` files
in the `naproche` directory!

