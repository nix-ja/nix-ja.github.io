{
  description = "nix-ja website";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./calendar.nix
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        { system, ... }:
        let
          overlay = final: prev: {
            toml-to-ical = prev.callPackage ./packages/toml-to-ical.nix { };
          };
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              overlay
            ];
          };
        in
        {
          _module.args.pkgs = pkgs;
          formatter = pkgs.nixfmt-tree;
          packages.toml-to-ical = pkgs.toml-to-ical;
        };
      flake = {
      };
    };
}
