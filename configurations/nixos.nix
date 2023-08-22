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
          } ++ [
            (final: prev: {
              cod =
                let
                  src = prev.fetchFromGitHub {
                    owner = "dim-an";
                    repo = "cod";
                    rev = "93e4c06c75ec2a77cf624c00558181a971b18e07";
                    hash = "sha256-dHc8S54qHIXo+0ZRT8cVdg2itVD7eyHeNCKkRPNa1VE=";
                  };
                in
                  prev.cod.override (_: rec {
                    buildGoModule = args: prev.buildGoModule ( args // {
                      inherit src;
                      vendorSha256 = "sha256-bJdyRFW8bPoweI2V5n/WBUEqlQ33QT4FqLTQtiKHYic=";
                    });
                  });
              })
          ];
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
