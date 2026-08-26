{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  nushell,
}:

stdenv.mkDerivation rec {
  pname = "makker";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "Pivok7";
    repo = "makker";
    tag = "v${version}";
    sha256 = "sha256-YRP4da8CIMdaJa/oQOo/Nf0+hHZqPkORCh+Qjx/AwhA=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/makker $out/bin
    cp -r ${src}/templates $out/bin
    wrapProgram $out/bin/$pname \
      --prefix PATH : ${
        lib.makeBinPath [
          nushell
        ]
      }
  '';

  meta = with lib; {
    description = "Project template manager";
    homepage = "https://github.com/Pivok7/makker";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
