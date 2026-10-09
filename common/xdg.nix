{ config, ... }:

let
  term =
    if
      (config ? metronome && config.metronome ? defaults && config.metronome.defaults.terminal != null)
    then
      config.metronome.defaults.terminal
    else
      "kitty";
in
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

    exec = "${term} -e nvim %F";
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

  xdg.desktopEntries.zathura = {
    name = "Zathura";
    genericName = "Document Viewer";
    exec = "zathura %F";
    terminal = false;
    type = "Application";
    categories = [
      "Office"
      "Viewer"
    ];
    mimeType = [
      "application/pdf"
      "application/x-pdf"
      "application/postscript"
      "application/oxps"
      "application/vnd.ms-xpsdocument"
      "image/vnd.djvu"
      "application/x-cbz"
      "application/x-cbr"
    ];
  };
}
