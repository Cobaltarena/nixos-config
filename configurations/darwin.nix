{ inputs
, lib
, self
, helpers
, home-manager-special-args
}:

let
  darwinSystemWrapper = system: extraModules:
    let
      pkgs = helpers.genPkgsWithOverlays system;
    in
      inputs.darwin.lib.darwinSystem {
        inherit system;
        specialArgs =  {
          inherit lib pkgs inputs self;
          inherit (inputs) darwin;
        };
        modules = [
          ./Doctolib.nix
          inputs.home-manager.darwinModules.home-manager
          (home-manager-special-args // {
            nixpkgs.overlays = helpers.defineSharedOverlays {
              inherit system;
            } ++ builtins.attrValues self.overlays;
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
  doctolib = darwinSystemWrapper "aarch64-darwin" [
    ./hosts/doctolib/default.nix
  ];
}
