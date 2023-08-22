{
  description = "Nixos configuration with flakes";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable-small = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable-small";
    };

    flake-utils = {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      ref = "main";
    };

    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      ref = "master";
    };

    darwin = {
      type = "github";
      owner = "LnL7";
      repo = "nix-darwin";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland  = {
      url = "github:nix-community/nixpkgs-wayland?rev=6520ad9164b8a1351b8f221c7364b8ee690f606d";
    };

    hyprland = {
      url = "github:hprwm/Hyprland?rev=2df0d034bc4a18fafb3524401eeeceaa6b23e753";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      overlays = import ./overlay;

      home-manager-special-args = rec {
        useGlobalPkgs = true;
        useUserPackages = true;
        verbose = true;
      };
      helpers = import ./helpers.nix;
    in
    {
      darwinConfigurations = import ./configurations/darwin.nix {
        inherit
          helpers
          home-manager-special-args
          inputs
          lib
          self
          ;
      };
      nixosConfigurations = import ./configurations/nixos.nix {
        inherit
          helpers
          home-manager-special-args
          inputs
          lib
          self
          ;
      };
    };
}
