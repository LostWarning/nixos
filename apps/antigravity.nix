# packages/antigravity.nix
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.metronome.apps.antigravity;
in
{
  options.metronome.apps.antigravity = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install antigravity";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.llm-agents.packages.${system}.antigravity-cli
    ];
  };
}
