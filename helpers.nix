{ inputs }:

{
  defineSharedOverlays = { system }: [
    (self: super: {
      # packages accessible through pkgs.unstable.package
      unstable = import inputs.nixpkgs-unstable-small {
        inherit system;
        inputs.nixpkgs.config.allowUnfree = true;
      };
    })
  ];
  genPkgsWithOverlays = { system }: import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
}
