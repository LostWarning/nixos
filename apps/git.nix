{
  config,
  lib,
  fullName,
  email,
  ...
}:

{
  options.custom.apps.git.enable = lib.mkEnableOption "Git";

  config = lib.mkIf config.custom.apps.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = fullName;
          email = email;
        };
        init.defaultBranch = "main";
      };

    };
  };
}
