# Switching system config

```sudo nixos-rebuild switch --flake .```

# Switching home config

```nix build .#homeManagerConfigurations.adam@Isolde.activationPackage && ./result/activate```

or

```home manager switch --flake```
