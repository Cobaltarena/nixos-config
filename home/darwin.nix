{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.darwin;
  # hm = inputs.home-manager.lib;
  appEnv = pkgs.buildEnv {
    name = "home-manager-applications";
    paths = config.home.packages;
    pathsToLink = "/Applications";
  };
in

with lib;

{
  options.darwin = {
    installApps = mkOption {
      default = false;
      example = true;
      description = ''
        Install packages as Apps into ~/Applications/Home Manager Apps/
        Note: Disabled by default due to conflicting behavior with nix-darwin. See https://github.com/nix-community/home-manager/issues/1341#issuecomment-687286866
      '';
      type = types.bool;
    };
  };

  config.home = {
    packages = [
      pkgs.darwinRebuildSwitch
      pkgs.darwinRebuild
    ];
  } // mkIf (pkgs.stdenv.hostPlatform.isDarwin && cfg.installApps) {
    # The module system doesn't seem to like ternaries, we need to work with mkIfs.
    activation = mkIf cfg.installApps {
      copyApplications =
        let
          apps = pkgs.buildEnv {
            name = "home-manager-applications";
            paths = config.home.packages;
            pathsToLink = "/Applications";
          };
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          baseDir="/Applications"
          mkdir -p "$baseDir"
          echo "Base apps path: ${apps}"
          for appFile in ${apps}/Applications/*; do
            target="$baseDir/$(basename "$appFile")"
            echo "Target: $target"
            cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
            chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
          done
        '';
    };
  };
}
