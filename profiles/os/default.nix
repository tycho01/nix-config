{ pkgs, ... }:

{

  # search packages:
  # - `nix-env -qaP | grep wget`
  # - `nox wget`
  # - https://github.com/NixOS/nixpkgs/
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    nox
    mkpasswd
    tmux
  ];

  users.mutableUsers = false;

}
