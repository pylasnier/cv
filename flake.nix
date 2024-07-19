{
  inputs = {
    nixpkgs.url = "nixpkgs";
  };


  outputs = { nixpkgs, ... }:

  let system = "x86_64-linux"; in with nixpkgs.legacyPackages.${system}; {
    devShells.${system}.default = mkShell {
      packages = [
        pandoc
        texliveFull
      ];
    };
  };
}
