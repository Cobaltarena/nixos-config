{ lib, default, description }:
(lib.mkEnableOption description) // { inherit default; }
