{ pkgs, ... }:

{
  programs.ssh = {
    #    enable = true;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/stranger/.ssh/id_ed25519";
      };
    };
  };

  # Ensure the ssh-agent service starts with your graphical/user session
  services.ssh-agent.enable = true;
}
