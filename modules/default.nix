{ ... }:

{
  imports = [
    ./dev
    ./networking

    ./ai.nix
    ./audio.nix
    ./containers.nix
    ./display-manager.nix
    ./editor.nix
    ./games.nix
    ./terminal.nix
    ./window_manager.nix
  ];
}
