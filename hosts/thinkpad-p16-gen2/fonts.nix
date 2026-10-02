{ pkgs, ... }:

{
  # Enable Fontconfig integration in Home Manager
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only

      # General UI & Fallback fonts
      noto-fonts
      noto-fonts-color-emoji
      dejavu_fonts

      # May be needed by steam
      noto-fonts-cjk-sans
      liberation_ttf
      corefonts

    ];
    fontconfig = {
      enable = true;

      # Set default font family aliases across all apps
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "FiraCode Nerd Font"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans"
        ];
        serif = [
          "DejaVu Serif"
          "Noto Serif"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
