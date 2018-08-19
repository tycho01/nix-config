# https://github.com/ghuntley/dotfiles-nixos/tree/master/machines
{ pkgs, ... }:

{
  imports = [
    ../profiles/os/client.nix
    ../profiles/os/tychotop.nix
  ];

  # Speed up development at the cost of possible build race conditions
  nix.buildCores = 4;

  networking.hostName = "klink";

  fileSystems."/drogon" =
  { device = "/dev/sda4";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # https://askubuntu.com/questions/742946/how-to-find-the-hwdb-header-of-a-general-input-device#743291
  # services.udev.extraHwdb = ''
  #   # klink MSI keyboard
  #   # keyboard:usb:v045Ep00DB*
  #   # KEYBOARD_KEY_c022d=pageup
  #   # KEYBOARD_KEY_c022e=pagedown
  #   Alt_R = Menu
  #   Caps_Lock = Multi_key
  # '';

  # https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg
  # https://help.ubuntu.com/community/GtkComposeTable
  # bugged, fix in new gnome: https://github.com/NixOS/nixpkgs/issues/14318#issuecomment-361121902
  # services.xserver.xkbVariant = "colemak";
  # services.xserver.xkbOptions = "caps:backspace"; # compose:caps,menu:ralt

}