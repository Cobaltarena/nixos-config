# Switching system config

```sudo nixos-rebuild switch --flake .```

# Switching home config

```nix build .#homeManagerConfigurations.gawain@Camelot.activationPackage && ./result/activate```

or

```home manager switch --flake```
