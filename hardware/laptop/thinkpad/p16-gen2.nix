{ ... }:

{

  # Disable power-profiles-daemon and enable TLP
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Battery charge thresholds (optional, extends battery lifespan if plugged in often)
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  hardware.sensor.iio.enable = true;

  boot.kernelModules = [ "thinkpad_acpi" ];
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
  '';

  services.thinkfan = {
    enable = true;
  };

  services.thermald.enable = true;

  services.logind = {
    settings.Login = {
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitch = "suspend";
    };
  };

  boot.kernelParams = [
    "pcie_aspm=force"
  ];

}
