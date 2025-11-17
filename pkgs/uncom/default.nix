{
  stdenv,
  fetchFromGitHub,
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
    rev = "2074acc54a3117e41eb0631abd54c9af6a9171f9";
    sha256 = "sha256-ghL5qYKrGQmN5TxV5/3aVKWpCaPmTWfqtO+J35NzZuY=";
  };

  nativeBuildInputs = [
    zig.hook
  ];

  buildInputs = [
    unzip
    xz
    bzip2
    p7zip
  ];

  strictDeps = true;

  zigBuildFlags = [
    "-Doptimize=ReleaseFast"
  ];

  meta = with lib; {
    description = "Universal uncompressor";
    homepage = "https://github.com/Pivok7/uncom";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
