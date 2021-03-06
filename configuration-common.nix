# see `nixos-help`, https://nixos.org/nixos/options.html
# https://github.com/ghuntley/dotfiles-nixos/blob/master/configuration-common.nix

# Most of the configuration is in here. This configuration is common to both
# conventional NixOS installs (see nixos-install) and NixOS installed by
# Nixops. For configuration specific to conventional installs and Nixops
# installs, see ./configuration.nix and ./nixops.nix respectively.

{ config, lib, pkgs, ... }:
with lib;

{
  imports = [
    ./services/default.nix
    ./users/tycho.nix
  ];

  # Allow proprietary software (such as the NVIDIA drivers).
  nixpkgs.config.allowUnfree = true;

  boot = {

    # See console messages during early boot.
    initrd.kernelModules = [ "fbcon" ];

    # Disable console blanking after being idle.
    kernelParams = [ "consoleblank=0" ];
 
    # Clean /tmp on boot
    cleanTmpDir = true;

  };
 
  # automatic updates every day
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable-small";
  };

  # automatic gc
  nix.gc = {
    automatic = true;
    dates = "03:15";
    options = "--delete-older-than 30d";
  };

  security.sudo.enable = true;

  # Disable displaying the NixOS manual in a virtual console.
  services.nixosManual.showManual = false;

  # Disable the infamous systemd screen/tmux killer
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandlePowerKey=suspend
      KillUserProcesses=no
    '';
  };

  # Increase the amount of inotify watchers
  # Note that inotify watches consume 1kB on 64-bit machines.
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    # consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    consoleUseXkbConfig = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Use the systemd-boot EFI boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NixOS release with which your system is to be compatible,
  # change only after NixOS release notes say you should.
  system.stateVersion = "19.03";

  # restrict process info access to owning user
  security.hideProcessInformation = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
      url = "https://github.com/nix-community/NUR/archive/3a6a6f4da737da41e27922ce2cfacf68a109ebce.tar.gz";
      # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
      sha256 = "04387gzgl8y555b3lkz9aiw9xsldfg4zmzp930m62qw8zbrvrshd";
}) {
      inherit pkgs;
    };
  };

}
