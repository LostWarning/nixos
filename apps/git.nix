{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.git;
in
{
  options.metronome.apps.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install git";
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "git config name";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "git config email";
    };

    defaultBranch = lib.mkOption {
      type = lib.types.str;
      default = "main";
      description = "default branch name";
    };

  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = cfg.name;
          email = cfg.email;
        };
        init.defaultBranch = cfg.defaultBranch;
      };
    };
  };
}
