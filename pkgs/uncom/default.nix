{
  lib,
  stdenv,
  fetchFromRadicle,
  makeWrapper,
  nushell,
  gnutar,
  unzip,
  xz,
  bzip2,
  gzip,
  p7zip,
  zstd,
}:

stdenv.mkDerivation rec {
  pname = "uncom";
  version = "2.0.0";

  src = fetchFromRadicle {
    seed = "pivok.radicle.garden";
    repo = "z48Wnoe5hoPP4MfnUBUmNYaNmuWWF";
    tag = "v${version}";
    sha256 = "sha256-b7lkCEiyMMxG2rltlvPiUNwrG4enmo6IbXpCqJpNEoM=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  dontUseZigInstall = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/uncom $out/bin
    wrapProgram $out/bin/$pname \
      --prefix PATH : ${
        lib.makeBinPath [
          nushell
          gnutar
          unzip
          xz
          bzip2
          gzip
          p7zip
          zstd
        ]
      }
  '';

  meta = with lib; {
    description = "Universal uncompressor";
    homepage = "https://github.com/Pivok7/uncom";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
