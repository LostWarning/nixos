{ config, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = "${config.home.homeDirectory}/Public";
    templates = "${config.home.homeDirectory}/Templates";
    videos = "${config.home.homeDirectory}/Videos";
  };

  xdg.desktopEntries.nvim = {
    name = "Neovim";

    exec = "kitty -e nvim %F";
    terminal = false;
    type = "Application";
    categories = [
      "Utility"
      "TextEditor"
    ];
    mimeType = [
      "text/plain"
      "application/x-zerosize"
    ];
  };
}
