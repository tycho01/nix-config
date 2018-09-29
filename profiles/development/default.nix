{ config, lib, pkgs, ... }:

let
  nvidiaDocker = import ./nvidia-docker/default.nix { inherit pkgs; };
in
{
  imports = [
    ./haskell.nix
    ./python.nix
    ./ruby.nix
    ./web.nix
    ./servers.nix
    ./compilers.nix
    ./latex.nix
    ./mathematics.nix
  ];

  # install development packages
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    binutils-unwrapped
    zlib
    protobuf
    nvidiaDocker
    snappy
    nix-generate-from-cpan
    libtool
    unzip
    autoconf
    automake
    autogen
    gnum4
    openssl
    c-ares
    curl
    libraw
    sqlite
  ];

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {

    myNeoVimPlugins = pkgs.neovim.override {
      configure = {
        customRC = ''
          # custom configuration
        '';
        plug.plugins = with pkgs.vimPlugins; [
          vim-go
          syntastic
          nerdtree
          ctrlp.vim
          vim-airline
          youcompleteme
          vim-fugitive
          nerdtree
          ghcmod-vim
        ];
      };
    };

    myVimPlugins = pkgs.vim_configurable.customize {
      name = "vim-with-plugins";
      vimrcConfig.vam.knownPlugins = pkgs.vimPlugins; # optional
      vimrcConfig.vam.pluginDictionaries = [
        # load always
        {
          names = [
            "vim-go"
            "syntastic"
            "nerdtree"
            "ctrlp.vim"
            "vim-airline"
            "youcompleteme"
            "vim-fugitive"
            "nerdtree"
          ];
        }

        # only load when opening a .hs file
        { name = "ghcmod-vim"; ft_regex = "^hs\$"; }
        # { name = "ghcmod-vim"; filename_regex = "^.hs\$"; }

        # provide plugin which can be loaded manually:
        # { name = "syntastic"; tag = "lazy"; }
      ];
    };

  };

}
