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
    tag = "v1.1.0";
    sha256 = "sha256-rbD56ZN3mmx/XcNUxIcdFWT1bJ/Lzf6pQc/yERfLRk4=";
  };

  nativeBuildInputs = [
    zig.hook
  ];

  meta = with lib; {
    description = "Project template manager";
    longDescription = "Easily create templates for c, c++ and zig";
    homepage = "https://github.com/Pivok7/makker";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
