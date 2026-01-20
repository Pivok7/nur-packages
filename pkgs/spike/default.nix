{
  lib,
  stdenv,
  callPackage,
  makeWrapper,
  fetchgit,
  libGL,
  libxkbcommon,
  wayland,
  zig,

  # Usually you would override `zig.hook` with this, but we do that internally
  # since upstream recommends a non-default level
  # https://github.com/ghostty-org/ghostty/blob/4b4d4062dfed7b37424c7210d1230242c709e990/PACKAGING.md#build-options
  optimizeLevel ? "ReleaseFast",
}:
let
  zig_hook = zig.hook.overrideAttrs {
    zig_default_flags = "-Dcpu=baseline -Doptimize=${optimizeLevel} --color off";
  };
in
stdenv.mkDerivation (finalAttrs: rec {
  pname = "spike";
  version = "0.1.0";

  src = fetchgit {
    url = "https://codeberg.org/Pivok/spike";
    rev = "9eee3f282bdb7434b313bb429ae7e65ba3ed7771";
    hash = "sha256-LnHIY5GDFo77shfr+LyqbxFjltN59lseUJDF7dIjxWE=";
  };

  deps = callPackage ./deps.nix {
    name = "${finalAttrs.pname}-cache-${finalAttrs.version}";
  };

  strictDeps = true;

  nativeBuildInputs = [
    makeWrapper
    zig_hook
  ];

  buildInputs = [
    libGL
    libxkbcommon
    wayland
  ];

  zigBuildFlags = [
    "--system"
    "${finalAttrs.deps}"
  ];

  # This is here because SDL likes to dlopen a lot
  postInstall = ''
    wrapProgram $out/bin/$pname \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}
  '';

  zigCheckFlags = finalAttrs.zigBuildFlags;

  doInstallCheck = true;

  meta = with lib; {
    description = "Experimental terminal";
    homepage = "https://codeberg.org/Pivok/spike";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
