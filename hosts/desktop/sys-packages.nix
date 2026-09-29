{ ... }:

{
  imports = [
    ../../packages/ollama.nix

    ../../services

  ];

  custom.services = {
    docker.enable = true;
    greetd.enable = true;
    nginx.enable = true;
    steam.enable = true;
  };
}
