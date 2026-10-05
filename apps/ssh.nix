{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.ssh;
  sshKey = "${config.home.homeDirectory}/.ssh/id_ed25519";
in
{
  options.metronome.apps.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable SSH configuration and auto-key generation";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          addKeysToAgent = "yes";
        };
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = sshKey;
        };
      };
    };

    # Automatically generate key if it doesn't exist (pure user-space, no root systemd needed)
    home.activation.generateSshKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -f "${sshKey}" ]; then
        echo "Generating new Ed25519 SSH key for ${config.home.username}..."
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.ssh"
        $DRY_RUN_CMD chmod 700 "${config.home.homeDirectory}/.ssh"
        $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -C "${config.home.username}@$(hostname)" -f "${sshKey}" -N ""
        $DRY_RUN_CMD chmod 600 "${sshKey}"
        $DRY_RUN_CMD chmod 644 "${sshKey}.pub"
      fi
    '';
  };
}
