# Pokémon TCG [![Build Status][ci-badge]][ci]

This is a disassembly of Pokémon TCG.

It builds the following ROM:

- Pokémon Trading Card Game (U) [C][!].gbc `sha1: 0f8670a583255cff3e5b7ca71b5d7454d928fc48`

To assemble, first download RGBDS (https://github.com/gbdev/rgbds/releases) and extract it to /usr/local/bin.
Run `make` in your shell.

This will output a file named "poketcg.gbc".


## See also

- [**Symbols**][symbols]

For contacts and other pret projects, see [pret.github.io](https://pret.github.io/).

[symbols]: https://github.com/pret/poketcg/tree/symbols
[ci]: https://github.com/pret/poketcg/actions
[ci-badge]: https://github.com/pret/poketcg/actions/workflows/main.yml/badge.svg
