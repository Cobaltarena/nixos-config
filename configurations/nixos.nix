{ inputs
, lib
, self
, helpers
, home-manager-special-args
}:

let
  nixosModuleWrapper = { system, extraModules, hostname }:
    let
      nixosModules = {
        home = rec {

          home-manager = {
            users.${hostname} = import ../home {
              username = "${hostname}";
              isDarwin = false;
              inherit inputs;
            };
          } // home-manager-special-args;
        };
        nix-path = {
          nix.nixPath = [
            "nixpkgs=${inputs.nixpkgs}"
          ];
        };
      };
      modules = [

        inputs.home-manager.nixosModule
        {
          nixpkgs.config.allowBroken = true;
          nixpkgs.overlays = helpers.defineSharedOverlays {
            inherit system;
            baseInputChannel = inputs.nixpkgs-unstable-small;
          } ++ import ../overlay;
        }
      ] ++ extraModules ++ (inputs.nixpkgs.lib.attrValues nixosModules);
    in
      inputs.nixpkgs.lib.nixosSystem rec {
        specialArgs = { inherit inputs; };
        inherit modules system;
      };
in
{
  camelot = nixosModuleWrapper {
    system = "x86_64-linux";
    extraModules = [
      ../Camelot.nix
    ];
    hostname = "gawain";
  };
}
