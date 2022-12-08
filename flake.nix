{
  # This is a template created by `hix init`
  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    let
      supportedSystems = [
        "x86_64-darwin"
      ];
    in
      flake-utils.lib.eachSystem supportedSystems (system:
      let
        overlays = [ haskellNix.overlay
          (final: prev: {
            hello-world =
              final.haskell-nix.stackProject' {
                src = ./.;
                modules = [
                  {
                    reinstallableLibGhc    = false;
                  }
                ];


              };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
        flake = pkgs.hello-world.flake {};
      in flake // {
        packages = flake.packages // {
          default = flake.packages."hello-world:exe:hello-world";
        };
        devShell = pkgs.system.hello-world.shellFor({
          inherit system;
          withHoogle = false;
          # exactDeps = true; # TODO: Uncomment and have it work.
          tools = {
            haskell-language-server = {};
          };
          additional = hsPkgs: with hsPkgs; [ Cabal ghc ghc-lib-parser ];
          # buildInputs =
          #   let # Wrap Stack to work with our Nix integration. We don't want to modify
          #       # stack.yaml so non-Nix users don't notice anything.
          #       # - no-nix: We don't want Stack's way of integrating Nix.
          #       # --system-ghc    # Use the existing GHC on PATH (will come from this Nix file)
          #       # --no-install-ghc  # Don't try to install GHC if no matching GHC found on PATH
          #       stack-wrapped = with pkgs; symlinkJoin {
          #         name = "stack"; # will be available as the usual `stack` in terminal
          #         paths = [ stack ];
          #         buildInputs = [ makeWrapper ];
          #         postBuild = ''
          #           wrapProgram $out/bin/stack \
          #             --add-flags "\
          #               --no-nix \
          #               --system-ghc \
          #               --no-install-ghc \
          #             "
          #         ''; #TODO: parameterize ghc version
          #       };
          #   in (with pkgs; [
          #     postgresqlWithPackages
          #     stack-wrapped
          #     stack2cabal
          #     cabal-install
          #     yq-go
          #     python3Full
          #     ghcid
          #     hasktags
          #     haskellPackages.haskdogs
          #     haskellPackages.cabal-fmt
          #     pcre
          #     yarn
          #     minio
          #     nodejs18
          #     minio-client
          #     git
          #     cacert
          #     bzip2
          #     zlib
          #     less
          #     which
          #     ormolu
          #     hlint
          #     ] ++ (if pkgs.stdenv.isDarwin then [
          #       darwin.apple_sdk.frameworks.Cocoa
          #       darwin.apple_sdk.frameworks.CoreFoundation
          #       darwin.apple_sdk.frameworks.CoreServices
          #     ] else []));

        });
        legacyPackages = pkgs;
      });

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    # This sets the flake to use the IOG nix cache.
    # Nix should ask for permission before using it,
    # but remove it here if you do not want it to.
    extra-substituters = ["https://cache.iog.io"];
    extra-trusted-public-keys = ["hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
    allow-import-from-derivation = "true";
  };
}
