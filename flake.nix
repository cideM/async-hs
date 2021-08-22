{
  description = "Demonstrating issues with async Haskell and background processes";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          app = pkgs.haskellPackages.callPackage ./project.nix { };
        in
        rec {
          packages = flake-utils.lib.flattenTree ({
            inherit app;
          });

          defaultPackage = packages.app;

          apps.server = flake-utils.lib.mkApp { drv = app; exePath = "/bin/async-hs"; };
          apps.demo = flake-utils.lib.mkApp { drv = app; exePath = "/bin/demo"; };

          devShell = pkgs.mkShell {
            inputsFrom = [ app.env ];
            buildInputs = with pkgs.haskellPackages; [
              # Haskell
              ghcid
              ormolu
              hlint
              cabal2nix
              haskell-language-server
              cabal-install
              cabal-fmt
              fast-tags
              hoogle

              pkgs.nixpkgs-fmt
            ];
          };

        }
      );
}
