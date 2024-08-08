{ stdenv
, lib
, pandoc
, texliveFull
, target ? "bucket"
}:

stdenv.mkDerivation {
  pname = "pascal-cv";
  version = "2024";

  src = lib.cleanSourceWith {
    src = ./.;
    filter = path: _type: baseNameOf path != "build";
  };

  nativeBuildInputs = [
    pandoc
    texliveFull
  ];

  buildFlags = [ "pdf" "gfm" "TARGET=${target}" ];
  postBuild = ''
    mkdir -p $out/doc
    cp build/*.pdf build/*.md $out/doc
  '';

  dontInstall = true;
}
