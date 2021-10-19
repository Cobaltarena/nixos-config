{ pkgs, callPackage, ... }: {

  services.redshift = {
    enable = true;
    settings = {
      redshift = {
        brightness-day = "1";
        brightness-night = "1";
      };
    };
    provider = "manual";
    latitude = 48.8534;
    longitude = 2.3488;
    temperature = {
      day = 5500;
      night = 3700;
    };
  };
}
