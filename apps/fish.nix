{
  osConfig,
  lib,
  ...
}:

{
  programs.fish = lib.mkIf (osConfig.metronome.terminal.shell == "fish") {
    enable = true;

    interactiveShellInit = ''
      # Auto-start ssh-agent and add key if not already running
      if not set -q SSH_AUTH_SOCK
        eval (ssh-agent -c)
        ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1
      end
    '';
  };
}
