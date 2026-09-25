{ pkgs, ... }:

{
  home.packages = with pkgs; [
    posting
  ];

  xdg.configFile."posting/config.yaml".text = ''
    theme: "tokyo-night"
    editor: "nvim"
  '';
}
