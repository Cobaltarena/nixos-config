{ lib, generateOptions }:

{
  browser = generateOptions { inherit lib; default = true; description = "Enable browser"; };
  discord = generateOptions { inherit lib; default = true; description = "Enable discord"; };
  i3 = generateOptions { inherit lib; default = false; description = "Enable i3"; };
  redshift = generateOptions { inherit lib; default = true; description = "Enable redshift"; };
  rofi = generateOptions { inherit lib; default = true; description = "Enable rofi"; };
  slack = generateOptions { inherit lib; default = false; description = "Enable slack"; };
  x = generateOptions { inherit lib; default = false; description = "Enable x"; };
}
