{
  pkgs ? (builtins.getFlake (toString ./..)).nixosConfigurations.desktop.pkgs,
}:

let
  flake = builtins.getFlake (toString ./..);

  sysDoc = pkgs.nixosOptionsDoc {
    options = { inherit (flake.nixosConfigurations.desktop.options) metronome; };
    warningsAreErrors = false;
  };

  hm = flake.inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { osConfig = null; };
    modules = [
      {
        home.username = "docgen";
        home.homeDirectory = "/home/docgen";
        home.stateVersion = "26.05";
      }
      ../apps
      ../profiles
      ../common/theme.nix
    ];
  };

  userDoc = pkgs.nixosOptionsDoc {
    options = { inherit (hm.options) metronome; };
    warningsAreErrors = false;
  };

  jqFilter = ''
    def clean_opt(scope; item):
      {
        name: item.key,
        scope: scope,
        category: (item.key | split(".")[1]),
        type: (item.value.type // "unspecified"),
        default: (if item.value.default? then (item.value.default.text // item.value.default) else null end),
        example: (if item.value.example? then (item.value.example.text // item.value.example) else null end),
        description: (item.value.description // ""),
        declarations: (item.value.declarations // [] | map(sub("^(/etc/nixos/|.*/[a-z0-9]*-source/)"; "")))
      };

    ($sys[0] | to_entries | map(clean_opt("system"; .))) as $s |
    ($usr[0] | to_entries | map(clean_opt("user"; .))) as $u |

    (($s + $u) | group_by(.name) | map(
      if length > 1 then
        .[0] + { scope: "shared" }
      else
        .[0]
      end
    )) as $all |

    {
      meta: {
        total: ($all | length),
        categories: ($all | map(.category) | unique),
        scopes: ["system", "user", "shared"]
      },
      options: $all
    }
  '';
in
pkgs.runCommand "metronome-options.json" {
  nativeBuildInputs = [ pkgs.jq ];
} ''
  jq -n \
    --slurpfile sys "${sysDoc.optionsJSON}/share/doc/nixos/options.json" \
    --slurpfile usr "${userDoc.optionsJSON}/share/doc/nixos/options.json" \
    '${jqFilter}' > $out
''
