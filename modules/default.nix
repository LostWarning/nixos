{ ... }:

{
  imports = [
    ./dev
    ./networking

    ./audio.nix
    ./containers.nix
    ./display-manager.nix
    ./editor.nix
    ./games.nix
    ./terminal.nix
    ./window_manager.nix
  ];
}
