{ isDarwin, username ? "gawain", ... }@args:

let
  homePath = if isDarwin then "/Users" else "/home";
in
{
  fonts.fontconfig.enable = true;
  imports = [
    ./options
    ./profiles
    args.inputs.hyprland.homeManagerModules.default
  ] ++ (if isDarwin then [ ./darwin.nix ] else [ ]); # TODO: FIXME
  home.homeDirectory = "${homePath}/${username}";
  home.stateVersion = "21.11";
  home.username = "${username}";
}
