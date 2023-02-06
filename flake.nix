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
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , darwin
    , ... } @inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      overlays = import ./overlay;
      genPkgsWithOverlays = system: import nixpkgs {
          inherit system;
          config.allowUnfree = true;
      };
      home-manager-special-args = rec {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.verbose = true;
        nixpkgs.overlays = shared_overlays;
      };
      shared_overlays = [
        (self: super: {
          # packages accessible through pkgs.unstable.package
          unstable = import inputs.nixpkgs-unstable-small {
            inherit system;
            nixpkgs.config.allowUnfree = true;
          };
        })
      ] ++ builtins.attrValues self.overlays;
      darwinSystemWrapper = system: extraModules:
        let
          pkgs = genPkgsWithOverlays system;

        in
          darwin.lib.darwinSystem
            {
              inherit system;
              specialArgs =  { inherit lib pkgs inputs self darwin; };
              modules = [
                ./Doctolib.nix
                home-manager.darwinModules.home-manager
                (home-manager-special-args // {
                  home-manager.users.thomas = import ./home {
                    homePath = "/Users";
                    username = "thomas";
                    envOptions = {
                      x = false;
                      darwin = true;
                    };
                  };
                })
              ];
            };
    in
      {
        # Home config
        nixosModules = {
          homeConfiguration = home-manager.nixosModule
          {
            home-manager.users.gawain = import ./home {
              username = "gawain";
              envOptions = {
                x = true;
                darwin = false;
              };
            } // home-manager-special-args;
          nix-path = {
            nix.nixPath = [
              "nixpkgs=${inputs.nixpkgs}"
            ];
          };
          };
        };

        nixosConfigurations =
          let
            system = "x86_64-linux";
            sharedModules = (nixpkgs.lib.attrValues self.nixosModules);
          in {
            camelot = nixpkgs.lib.nixosSystem rec {
              specialArgs = { inherit inputs; };
              inherit system;
              modules = [
                ./Camelot.nix
              ] ++ sharedModules;
            };
          };
        processConfigurations = lib.mapAttrs (n: v: v n);
        darwinConfigurations = {
          doctolib = darwinSystemWrapper "aarch64-darwin" [ ./hosts/doctolib/default.nix ];
        };
      };
}
