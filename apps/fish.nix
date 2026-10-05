{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.fish;
  isDefault = (config.metronome.defaults.shell == "fish");
in
{
  options.metronome.apps.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "enable fish shell";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        # Auto-start ssh-agent and add key if not already running
        if not set -q SSH_AUTH_SOCK
          eval (ssh-agent -c)
          ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1
        end
      '';
    };
  };
}
