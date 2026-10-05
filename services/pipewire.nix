{
  lib,
  config,
  ...
}:

let
  cfg = config.metronome.services.pipewire;
  isDefault = (config.metronome.defaults.audio-backend == "pipewire");
in

{
  options.metronome.services.pipewire = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = isDefault;
      description = "Enable pipewire";
    };
  };

  config = lib.mkIf cfg.enable {

    services.pulseaudio.enable = false;

    security.rtkit.enable = true;

    security.pam.loginLimits = [
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "95";
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "nice";
        type = "-";
        value = "-19";
      }
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;

      # Dynamic sample rate switching (bit-perfect audio)
      extraConfig.pipewire = {
        "99-allowed-rates" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [
              44100
              48000
              88200
              96000
              176400
              192000
            ];
            "default.clock.quantum" = 1024;
            "default.clock.min-quantum" = 512;
            "default.clock.max-quantum" = 2048;
            "resample-quality" = 10;
          };
        };
      };

      wireplumber.extraConfig = {
        "10-disable-suspension" = {
          "monitor.alsa.rules" = [
            {
              matches = [ { "node.name" = "~alsa_output.*"; } ];
              actions = {
                update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
          ];
        };
      };
    };
  };
}
