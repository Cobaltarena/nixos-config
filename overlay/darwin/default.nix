final: prev: {
  darwinRebuildSwitch = pkgs.WriteShellScriptBin "darswitch" ''
      nix build -L -j 4 ~/.config/darwin#darwinConfigurations.doctolib.system --impure
      [ -L result ] || echo "No configuration to switch to" && exit 1
      sudo rm -rf /Users/$(whoami)/Applications/Home\ Manager\ Apps
      ./result/sw/bin/darwin-rebuild switch --flake ~/.config/darwin#doctolib
      unlink result
  '';

  darwinRebuild = pkgs.WriteShellScriptBin "darebuild" ''
      nix build -L -j 4 --no-link ~/.config/darwin#darwinConfigurations.doctolib.system --impure
  '';
}
