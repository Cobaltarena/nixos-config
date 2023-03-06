{ lib, generateOptions }:

{
  fileSystem = generateOptions { inherit lib; default = true; description = "Enable tools such as fzf or direnv"; };
  git = generateOptions { inherit lib; default = true; description = "Enable git"; };
  linuxTools = generateOptions { inherit lib; default = true; description = "Enable tools such as ldconfig or corutils"; };
  man = generateOptions { inherit lib; default = true; description = "Enable man"; };
  monitoring = generateOptions { inherit lib; default = true; description = "Enable terminal-based monitoring tools"; };
  terminalEmulator = generateOptions { inherit lib; default = true; description = "Enable a terminal emulator"; };
  textProcessing = generateOptions { inherit lib; default = true; description = "Enable tools such as jq or bat"; };
  zsh = generateOptions { inherit lib; default = true; description = "Enable zsh"; };
}
