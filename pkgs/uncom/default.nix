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

stdenv.mkDerivation {
  pname = "uncom";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Pivok7";
    repo = "uncom";
    rev = "555b81a6607245486fb4e45410ad1856c337b041";
    sha256 = "sha256-enbwIBtXaes8973y+6Frszx/QtH3T8XdLsFjjWauMA0=";
  };

  nativeBuildInputs = [
    makeWrapper
    zig.hook
  ];

  zigBuildFlags = [
    "-Doptimize=ReleaseFast"
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
