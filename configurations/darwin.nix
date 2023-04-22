{ inputs
, lib
, self
, helpers
, home-manager-special-args
}:

let
  darwinSystemWrapper = { system, extraModules, hostname }:
    let
      modules = [
        inputs.home-manager.darwinModules.home-manager
        ({
          home-manager = {
            users.${hostname} = import ../home {
              username = "${hostname}";
              isDarwin = true;
            };
          } // home-manager-special-args;
          nixpkgs.overlays = helpers.defineSharedOverlays {
            inherit system;
            baseInputChannel = inputs.nixpkgs-unstable-small;
          };
        })
      ] ++ extraModules;
    in
    inputs.darwin.lib.darwinSystem {
      inherit system modules;
      specialArgs = {
        inherit inputs;
      };
    };
in
{
  doctolib = darwinSystemWrapper {
    system = "aarch64-darwin";
    extraModules = [ ../Doctolib.nix ];
    hostname = "thomas";
  };
}
