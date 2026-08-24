{
  stdenv,
  fetchFromGitHub,
  lib,
  zig
}:

stdenv.mkDerivation rec {
  pname = "makker";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "Pivok7";
    repo = "makker";
    tag = "v${version}";
    sha256 = "sha256-4ZgkTStfVCnFIGoFjTDIE/m5ida/Hu1yAHQlttq7vjs=";
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
