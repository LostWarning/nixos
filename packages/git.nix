{
  pkgs,
  fullName,
  email,
  ...
}:

{
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
}
