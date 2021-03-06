{ pkgs, ... }:

let
  secrets = import ../../secrets.nix;
in
rec {

  # boot.blacklistedKernelModules = [ "i915" ];

  environment.systemPackages = with pkgs; [
    gparted
    apulse
  ];

  # touchpad
  services.xserver.libinput.enable = true;

  # sound
  # fix manually: settings -> sound -> input -> enable input, fix volume
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    # cpu.intel.updateMicrocode = true;
    bumblebee = {
      connectDisplay = true;
      enable = true;
    };
  };

  services.printing.enable = true;

}
