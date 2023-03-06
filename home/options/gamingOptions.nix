{ lib, generateOptions }:

{
  lutris = generateOptions { inherit lib; default = true; description = "Enable lutris"; };
  steam = generateOptions { inherit lib; default = true; description = "Enable steam"; };
}
