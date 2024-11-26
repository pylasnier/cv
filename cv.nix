{ stdenv
, lib
, pandoc
, texlive
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
    (texlive.withPackages (p: with p; [
      scheme-small
      enumitem
      tex-gyre
    ]))
  ];

  buildFlags = [ "pdf" "gfm" "TARGET=${target}" ];
  preBuild = ''
    export XDG_CACHE_HOME="$(mktemp -d)"
  '';
  postBuild = ''
    mkdir -p $out/doc
    cp build/*.pdf build/*.md $out/doc
  '';

  dontInstall = true;
}
