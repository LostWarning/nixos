{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      opener = {
        view_image = [
          {
            run = ''swayimg "$@"'';
            orphan = true;
            for = "unix";
          }
        ];
        play = [
          {
            run = ''mpv "$@"'';
            orphan = true;
            for = "unix";
          }
        ];
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
            for = "unix";
          }
        ];
      };
      open = {
        rules = [
          {
            mime = "text/*";
            use = [
              "edit"
              "open"
            ];
          }
          {
            mime = "image/*";
            use = [ "view_image" ];
          }
          {
            mime = "video/*";
            use = [ "play" ];
          }
          {
            mime = "audio/*";
            use = [ "play" ];
          }
          {
            url = "*";
            use = [
              "edit"
              "open"
            ];
          }
        ];
      };
    };
  };
}
