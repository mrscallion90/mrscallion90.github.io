{
  description = "Development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSystem = f:
        nixpkgs.lib.genAttrs systems (system:
          f nixpkgs.legacyPackages.${system}
        );
    in
    {
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            bun
            texliveSmall # provides pdflatex
          ];

          shellHook = ''
            alias hot-reload="bun --watch ./index.html"
            alias build-pdf="cd ${self}/latex && pdflatex ats.tex && mv ats.pdf ../assets/naufal-razin-ats-resume.pdf"
            
            echo "Development environment loaded"
            echo "Bun: $(bun --version)"
            echo "pdflatex: $(pdflatex --version)"
            echo
            echo "$ hot-reload # to start developing"
            echo "$ build-pdf   # to build ATS Resume PDFf"
          '';
        };
      });
    };
}
