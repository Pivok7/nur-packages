{
  stdenv,
  fetchFromGitHub,
  lib,
  zig
}:

stdenv.mkDerivation {
  pname = "makker";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "Pivok7";
    repo = "makker";
    rev = "fae8c9c08d0fe7de14b0b98c681e561d134b2cb2";
    sha256 = "sha256-OfjKEfsEE20s0l0dy0QYeNe28TxHNFGfMMT137FIklo=";
  };

  nativeBuildInputs = [
    zig.hook
  ];

  zigBuildFlags = [
    "-Doptimize=ReleaseFast"
  ];

  meta = with lib; {
    description = "Project template manager";
    longDescription = "Easily create templates for c, c++ and zig";
    homepage = "https://github.com/Pivok7/makker";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
