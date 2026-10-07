{
  pkgs ? (builtins.getFlake (toString ./..)).nixosConfigurations.desktop.pkgs,
}:

let
  flake = builtins.getFlake (toString ./..);
  lib = pkgs.lib;

  cleanPath = path:
    if path == null then null
    else builtins.replaceStrings
      [ (toString ./..) "/nix/store/" ]
      [ "" "" ]
      (toString path);

  cleanAppConfig = app:
    lib.mapAttrs (k: v:
      if k == "configFile" then cleanPath v
      else v
    ) app;

  getHostInfo = hostName: host: {
    inherit hostName;
    gpu = host.config.metronome.hardware.gpu;
    networking = {
      hostName = host.config.metronome.networking.hostName;
      nameservers = host.config.metronome.networking.nameservers;
      firewall = host.config.metronome.networking.firewall;
      networkmanager = host.config.metronome.networking.networkmanager.enable;
    };
    defaults = host.config.metronome.defaults;
    services = lib.filterAttrs (_name: s: s ? enable && s.enable == true) (
      lib.mapAttrs (_name: s:
        if builtins.isAttrs s then
          removeAttrs s [ "_module" ]
        else s
      ) host.config.metronome.services
    );
    displays = host.config.metronome.hardware.displays or { };
    systemPackages = lib.unique (
      map (p: p.name) (lib.filter (p: p ? name) host.config.environment.systemPackages)
    );
    users = lib.mapAttrs (userName: user: {
      inherit userName;
      defaults = user.metronome.defaults;
      profiles = lib.filterAttrs (_n: p: p ? enable && p.enable == true) user.metronome.profiles;
      apps = lib.filterAttrs (_n: a: a ? enable && a.enable == true) (
        lib.mapAttrs (_n: a: cleanAppConfig a) user.metronome.apps
      );
      theme = user.metronome.theme;
      displays =
        if user ? metronome.hardware.displays && user.metronome.hardware.displays != { } then
          user.metronome.hardware.displays
        else
          (host.config.metronome.hardware.displays or { });
      packages = lib.unique (
        map (p: p.name) (
          lib.filter (p: p ? name && !lib.hasPrefix "dummy-" p.name && !lib.hasSuffix "-reference-manpage" p.name) user.home.packages
        )
      );
    }) host.config.home-manager.users;
  };

  data = {
    generatedAt = "now";
    hosts = lib.mapAttrs getHostInfo flake.nixosConfigurations;
  };
in
pkgs.runCommand "metronome-installed.json" {
  nativeBuildInputs = [ pkgs.jq ];
} ''
  cat <<'EOF' > raw.json
  ${builtins.toJSON data}
EOF
  jq . raw.json > $out
''
