Deployed online at https://vadimkantorov.github.io/wasm-iconv.

# wasm-iconv
`iconv` program (from [GNU libiconv](https://www.gnu.org/software/libiconv)) compiled to WebAssembly using [Emscripten](https://github.com/emscripten-core/emscripten) and embedded in a single-file HTML.

`iconv.html` standalone file is also published in [Releases](/releases).

This repo can also serve as a primer of converting a UNIX utility program to a self-contained webpage.

# Build from souces

```shell
# assumes installed Emscripten's emcc/emmake

# download and extract GNU libiconv sources
which curl && make libiconv

# build and produce `./iconv.html`
which emcc && test -d libiconv && make iconv.html

# deploy `./iconv.html` to GitHub Pages by creating and pushing into `gh-pages` branch
which git && test -f iconv.html && make deploy
```

# License
MIT
