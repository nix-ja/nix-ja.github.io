{ config, lib, ... }:
let
  event =
    with lib.types;
    submodule {
      options = {
        uid = mkOption {
          type = str;
        };
        title = mkOption {
          type = str;
        };
        last_modified_on = mkOption {
          type = str;
        };
        start = mkOption {
          type = str;
        };
        end = mkOption {
          type = str;
        };
      };
    };
in
{
  options.calendar.events = lib.mkOption {
    type = lib.types.listOf event;
    default = [ ];
  };

  config = {
    perSystem =
      {
        pkgs,
        ...
      }:
      let
        calendarTOML = pkgs.writers.writeTOML "calendar.toml" {
          name = "nix-ja calendar";
          description = "Nix-ja event calendar";
          events = config.calendar.events;
        };
      in
      {
        packages.calendar = pkgs.runCommand "calendar.ics" { } ''
          mkdir -p $out
          ${pkgs.toml-to-ical}/bin/toml-to-ical --input ${calendarTOML} --output $out/calendar.ics
        '';
      };
  };
}
