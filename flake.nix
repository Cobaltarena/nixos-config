{
  description = "Nixos configuration with flakes";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
      # rev = "a7ecde854aee5c4c7cd6177f54a99d2c1ff28a31";
    };

    # nixpkgs-unstable-small = {
    #   type = "github";
    #   owner = "NixOS";
    #   repo = "nixpkgs";
    #   ref = "nixos-unstable-small";
    # };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ... } @inputs:
    let
      system = "x86_64-linux";
    in
      {
        # Home config
        nixosModules = {
          home = {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gawain = import ./home;
            home-manager.verbose = true;
          };
          nix-path = {
            nix.nixPath = [
              "nixpkgs=${inputs.nixpkgs}"
            ];
          };
        };

        overlays = import ./overlay;
        # TODO
        # System config
        nixosConfigurations =
          let
            system = "x86_64-linux";
            shared_overlays = [
              (self: super: {
                # packages accessible through pkgs.unstable.package
                unstable = import inputs.nixpkgs-unstable-small {
                  inherit system;
                  nixpkgs.config.allowUnfree = true;
                };
              })

            ] ++ builtins.attrValues self.overlays;
            sharedModules = [
              home-manager.nixosModule
              { nixpkgs.overlays = shared_overlays; }
            ] ++ (nixpkgs.lib.attrValues self.nixosModules);
          in {
            camelot = nixpkgs.lib.nixosSystem rec {
              specialArgs = { inherit inputs; };
              inherit system;
              modules = [
                ./Camelot.nix
              ] ++ sharedModules;
            };
          };
      };
}
