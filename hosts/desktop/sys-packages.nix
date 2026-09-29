{ ... }:

{
  imports = [
    ../../packages/ollama.nix

    ../../services

    ../../options.nix
  ];

  custom.services = {
    docker.enable = true;
    greetd.enable = true;
    nginx.enable = true;
    steam.enable = true;
  };
}
