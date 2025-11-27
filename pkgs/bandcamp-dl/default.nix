{
  lib,
  fetchFromGitHub,
  python313Packages,
}:

python313Packages.buildPythonPackage {
  pname = "bandcamp-dl";
  version = "0.0.17";

  src = fetchFromGitHub {
    owner = "Evolution0";
    repo = "bandcamp-dl";
    rev = "d7b4c4d6e7bfe365ee36514d6c608caf883e4476";
    sha256 = "sha256-PNyVEzwRMXE0AtTTg+JyWw6+FSuxobi3orXuxkG0kxw=";
  };

  patches = [
    # unicode-slugify has failing tests and is overall unmaintained and broken.
    # python-slugify is a preferrable replacement
    ./use_python_slugify.patch
  ];

  pyproject = true;
  build-system = with python313Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python313Packages; [
    beautifulsoup4
    demjson3
    mutagen
    requests
    python-slugify
    urllib3
  ];

  meta = with lib; {
    description = "Simple python script to download Bandcamp albums";
    homepage = "https://github.com/Evolution0/bandcamp-dl";
    license = licenses.unlicense;
    platforms = platforms.all;
  };
}
