{
  description = "Waypaper 2.9 custom flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.python3Packages.buildPythonApplication rec {
        pname = "waypaper";
        version = "2.9";

        pyproject = true;
        build-system = [ pkgs.python3Packages.setuptools ];

        src = pkgs.fetchFromGitHub {
          owner = "anufrievroman";
          repo = "waypaper";
          rev = "refs/tags/2.9";
          hash = "sha256-WrtbA1V+JBimr+VR0rOf/FFT6tzUXCvV8Ut8O1M2ElQ=";
        };

        propagatedBuildInputs = with pkgs.python3Packages; [
          pygobject3
          pillow
          importlib-metadata
          imageio
          imageio-ffmpeg
          screeninfo
          platformdirs
        ];

        buildInputs = [
          pkgs.gtk3
        ];

        nativeBuildInputs = [
          pkgs.gobject-introspection
          pkgs.wrapGAppsHook3
        ];
      };
    };
}
