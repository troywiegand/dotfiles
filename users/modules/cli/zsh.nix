{ config, lib, ... }: 
{
  config = {
    programs.zsh = {
      enable = true;
      initExtra = ''
        # Opens a file in the default program.
        open () {
          xdg-open "$1" & &> /dev/null
        }

        # ^S no longer pauses terminal
        stty -ixon

        nsn () {
          nix shell nixpkgs#"$1"
        }
        nrn () {
          nix run nixpkgs#"$1"
        }
        nix() {
          if [[ $1 == "develop" ]]; then
            shift
            command nix develop -c $SHELL "$@"
          else
            command nix "$@"
          fi
        }
      '';
      profileExtra = ''
        # add nix application desktop files
        XDG_DATA_DIRS=$HOME/.nix-profile/share:"''${XDG_DATA_DIRS}"
        PATH=/home/rutrum/.nix-profile/bin:$PATH
        VISUAL='nvim'
        EDITOR='nvim'
      '';
      shellAliases = {
        v = "nvim";
        j = "just";
        f = "fuck";
        py = "python3";

        # prompt on file overwrite
        cp = "cp -i";
        mv = "mv -i";

        # colors
        less = "less -R";
        ls = "lsd";
        grep = "grep --color=auto";

        # print human readable sizes
        du = "du -h";
        df = "df -h";
        ll = "ls -lhA";

        # navigation
        cdf = "cd $(fzf)";

        # nix shortcuts
        hms = "home-manager switch --flake ~/repos/dotfiles";
        snrs = "sudo nixos-rebuild switch --flake ~/repos/dotfiles";
        nd = "nix develop";
        nix-shell = "nix-shell --run $SHELL";
      };
    };
  };
}
