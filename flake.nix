{
  description = "Nixos configuration with flakes";
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    # nixpkgs-unstable-small = {
    #   type = "github";
    #   owner = "NixOS";
    #   repo = "nixpkgs";
    #   ref = "nixos-unstable-small";
    # };

    # emacs-overlay = {
    #   type = "github";
    #   owner = "nix-community";
    #   repo = "emacs-overlay";
    #   ref = "master";
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
      ref = "master";
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

        # overlays = import ./overlays;
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
                  config.allowUnfree = true;
                };
              })

            ]; # ++ builtins.attrValues self.overlays;
            sharedModules = [
              home-manager.nixosModule
              { nixpkgs.overlays = shared_overlays; }
            ] ++ (nixpkgs.lib.attrValues self.nixosModules);
          in {
            camelot = nixpkgs.lib.nixosSystem rec {
              inherit system;
              modules = [
                ./camelot.nix
              ] ++ sharedModules;
            };
          };
      };
}
