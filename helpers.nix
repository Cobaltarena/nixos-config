{
  defineSharedOverlays = { system, baseInputChannel }: [
    (self: super: {
      # packages accessible through pkgs.unstable.package
      unstable = import baseInputChannel {
        inherit system;
        inputs.nixpkgs.config.allowUnfree = true;
      };
    })
  ];
  genPkgsWithOverlays = { system, inputChannel }: import inputChannel {
    inherit system;
    config.allowUnfree = true;
  };
}
