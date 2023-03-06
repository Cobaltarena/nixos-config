{ lib, generateOptions }:

{
  c_cpp = generateOptions { inherit lib; default = false; description = "Enable c/cpp dev env"; };
  js = generateOptions { inherit lib; default = false; description = "Enable js/ts dev env"; };
  nix = generateOptions { inherit lib; default = true; description = "Enable nix dev env"; };
  python = generateOptions { inherit lib; default = true; description = "Enable python dev env"; };
  ruby = generateOptions { inherit lib; default = false; description = "Enable ruby dev env"; };
}
