{
  lib,
  stdenv,
  fetchFromRadicle,
  makeWrapper,
  nushell,
}:

stdenv.mkDerivation rec {
  pname = "makker";
  version = "2.2.2";

  src = fetchFromRadicle {
    seed = "pivok.radicle.garden";
    repo = "z2GiyL7zsKPQ3XWiPAKhbk5HaPVZh";
    tag = "v${version}";
    sha256 = "sha256-pTpPEdv4y2u7VCSqG4kXNhAvwYnMXjT3iEDeGP83SzI=";
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
