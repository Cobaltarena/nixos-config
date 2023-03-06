{ lib, generateOptions }:

{
  emacs = generateOptions { inherit lib; default = true; description = "Enable emacs"; };
  vscode = generateOptions { inherit lib; default = false; description = "Enable vscode"; };
}

