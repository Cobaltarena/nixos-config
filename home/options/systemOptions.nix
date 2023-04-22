{ lib, generateOptions }:

{
  bluetooth = generateOptions { inherit lib; default = false; description = "Bluetooth configuration tools"; };
  yubikey = generateOptions { inherit lib; default = false; description = "Yubikey configuration tools"; };
  gnupg = generateOptions { inherit lib; default = false; description = "Enable GPG related tools"; };
  virtualization = generateOptions { inherit lib; default = true; description = "Enable virtualization tools such as podman and docker-compose"; };
}
