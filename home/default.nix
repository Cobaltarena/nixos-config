{ envOptions ? {}, homePath ? "/home", username, ... }@args:

{
  fonts.fontconfig.enable = true;
  imports = [
    ./packages
    ./programs
    ./doctoenv.nix
  ]
  ++ (if envOptions.x then [ ./x ] else [])
  ++ (if envOptions.darwin then [ ./darwin.nix ] else []);
  home.homeDirectory = "${homePath}/${username}";
  home.stateVersion = "21.11";
  home.username = "${username}";
}
