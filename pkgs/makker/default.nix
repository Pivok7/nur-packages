{
  stdenv,
  fetchFromGitHub,
  lib,
  zig
}:

stdenv.mkDerivation {
  pname = "makker";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "Pivok7";
    repo = "makker";
    rev = "92314a55f7ee0fcff8294665f16723c060cb6d0e";
    sha256 = "sha256-RzxMVBG6FxNDSaLDLeZCIwpC6YLxjkDN99vj6I0dquc=";
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
    maintainers = [ maintainers.Pivok7 ];
    platforms = platforms.all;
  };
}
