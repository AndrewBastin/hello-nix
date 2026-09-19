{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "hello";
          version = "0.1";
          src = ./.;

          buildPhase = ''
            $CC hello.c -o hello
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp hello $out/bin/
          '';
        };
      }
    );
}
