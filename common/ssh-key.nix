{
  config,
  pkgs,
  username,
  ...
}:

let
  sshDir = "/home/${username}/.ssh";
  keyPath = "${sshDir}/id_ed25519";
in
{
  systemd.services.generate-ssh-key = {
    description = "Automatically generate SSH key pair if missing";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = username;
      RemainAfterExit = true;
    };

    script = ''
      if [ ! -f "${keyPath}" ]; then
        echo "Generating new Ed25519 SSH key for ${username}..."
        mkdir -p "${sshDir}"
        chmod 700 "${sshDir}"
        
        ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -C "${username}@${config.networking.hostName}" -f "${keyPath}" -N ""
        
        chmod 600 "${keyPath}"
        chmod 644 "${keyPath}.pub"
        echo "SSH key generated successfully!"
      else
        echo "SSH key already exists. Skipping generation."
      fi
    '';
  };

  programs.ssh.startAgent = true;
}
