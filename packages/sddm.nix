{ ... }:

{
  # Enable SDDM with Wayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Catppuccin SDDM integration
  catppuccin.sddm = {
    enable = true;
    flavor = "mocha";
    font = "Noto Sans";
    fontSize = "9";
    # background = "${./wallpaper.png}"; # Optional custom background
  };
}
