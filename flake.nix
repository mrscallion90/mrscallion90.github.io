{
  description = "Development Enviroment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bun
          ];
          shellHook = ''
            alias hot-reload="bun --watch ./index.html"
            echo "Environment loaded with Python and Node.js"
            echo "To get started:"
            echo "$ hot-reload"
          '';
        };
      }
    );
}   
