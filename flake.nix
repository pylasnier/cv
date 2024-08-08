{
  inputs = {
    nixpkgs.url = "nixpkgs";
  };


  outputs = { nixpkgs, ... }:

  let system = "x86_64-linux"; in with nixpkgs.legacyPackages.${system}; {
    packages.${system}.default = callPackage ./cv.nix { };
  };
}
