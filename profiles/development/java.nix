{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.jdk
    jetbrains.idea-ultimate
    jetbrains.pycharm-community
  ];
}
