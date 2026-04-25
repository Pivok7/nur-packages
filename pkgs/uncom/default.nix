{
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  lib,
  zig,
  unzip,
  xz,
  bzip2,
  p7zip,
}:

stdenv.mkDerivation rec {
  pname = "uncom";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "Pivok7";
    repo = "uncom";
    tag = "v${version}";
    sha256 = "sha256-udG2AFcTQpiApEkUuZDDRM1AQCD16wiQav/S3oY4SIk=";
  };

  nativeBuildInputs = [
    makeWrapper
    zig.hook
  ];

  dontUseZigInstall = true;

  installPhase = ''
    mkdir -p $out/bin
    mv zig-out/bin/uncom $out/bin/
    wrapProgram $out/bin/$pname \
      --prefix PATH : ${
        lib.makeBinPath [
          unzip
          xz
          bzip2
          p7zip
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
