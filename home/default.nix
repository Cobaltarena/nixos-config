{ isDarwin, username ? "gawain", ... }@args:

let
  homePath = if isDarwin then "/Users" else "/home";
in
{
  fonts.fontconfig.enable = true;
  imports = [
    ./packages
    ./programs
    ./doctoenv.nix
  ]
  ++ (if isDarwin then [ ./darwin.nix ] else [ ./x ]);
  home.homeDirectory = "${homePath}/${username}";
  home.stateVersion = "21.11";
  home.username = "${username}";
}
