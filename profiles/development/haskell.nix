{ pkgs, ... }:

let
  master = import ../../master.nix;
in
{
  environment.systemPackages = with master; [
    ctags
    cabal2nix
    cabal-install
    stack

    ghc
    # haskell.compiler.ghc822
    haskell.compiler.ghc843
  ] ++ (with haskellPackages; [

    # libraries
    QuickCheck      # testing, dep for some of the below
    exceptions      # dep
    process_1_6_3_0 # dep
    # cabal-helper    # dep  # https://github.com/NixOS/nixpkgs/issues/32631
    alex
    happy
    hakyll
    c2hs

    # tools
    # hscope
    # argon          # code complexity (req: haskell 7.10)
    # codex           # ctags file generator for cabal project dependencies
    # ghc-mod         # ghc-mod is a backend program to enrich editors  # https://github.com/NixOS/nixpkgs/issues/32969
    ghcid           # GHCi as a daemon
    # hasktags        # Produces ctags "tags" and etags "TAGS" files for Haskell programs 
    hlint           # linter
    hoogle          # type signature search
    hpack           # yaml based package format
    hspec           # testing framework
    intero          # IDE tooltips
    pointfree       # http://pointfree.io/
    pointful        # https://github.com/23Skidoo/pointful
    stylish-haskell # pretty printer
    tasty           # testing framework
    weeder          # dead code detection

    typedflow
  ]);
}
