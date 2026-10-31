{
  stdenv,
  lib,
  fetchFromGitHub,
  callPackage,
  zig_0_16,
}:

stdenv.mkDerivation (finalAttrs: rec {
  pname = "revo";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "if-not-nil";
    repo = "revo";
    tag = "${version}";
    sha256 = "sha256-uaYfcrugO28KYCrAxauHgk37fF5isDEK03j0sN+7MTQ=";
  };

  deps = callPackage ./deps.nix {};

  strictDeps = true;

  nativeBuildInputs = [
    zig_0_16.hook
  ];

  zigBuildFlags = [
    "--system"
    "${finalAttrs.deps}"
  ];

  zigCheckFlags = finalAttrs.zigBuildFlags;

  doInstallCheck = true;

  meta = with lib; {
    description = "revo, the programming language";
    longDescription = "revo is a dynamic language made for the joy of programming";
    homepage = "https://github.com/if-not-nil/revo";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
