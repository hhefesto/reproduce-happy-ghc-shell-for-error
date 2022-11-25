# Document Title

```sh
$ nix shell github:nixos/nixpkgs#stack github:input-output-hk/haskell.nix#hix
$ stack new hello-world simple
$ cd hello-world
$ ls
CHANGELOG.md  hello-world.cabal  LICENSE  README.md  Setup.hs  src  stack.yaml
$ git init
$ hix init
$ # change resolver in stack.yaml to `resolver: lts-20.1`
$ rm -r nix
$ # simple changes to flake.nix to remove hix, change hixProject to hello-world and add packages.default
$ git add -A
$ nix develop --show-trace
```
