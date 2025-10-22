{ pkgs, config, ... }:
{
  imports = [
    ./starship.nix
    ./neovim.nix
    ./nix.nix
    ./zsh.nix
  ];

  catppuccin = {
    gitui.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zellij.enable = true;
  };

  programs = {
    git = {
      enable = true;
      userEmail = "troy@troywiegand.com";
      userName = "Troy Wiegand";
      extraConfig = {
        pull.rebase = false;
        init.defaultBranch = "main";
        core.editor = "nvim";
      };
    };

    dircolors.enable = true;

    thefuck = {
      enable = true;
      enableBashIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    zellij = {
      enable = true;
      # this enables zellij on shell startup
      #enableBashIntegration = true;
      settings = {
       theme = "catppuccin-mocha";
      };
    };

    atuin = {
      enable = true;
      enableBashIntegration = true;
    };

    gitui = {
      enable = true;
    };

    htop = {
      enable = true;
      # htop overwrites the file all the time, causing home manager
      # to write backups all the time
      #settings = {
      #  hide_kernel_threads = true;
      #  hide_userland_threads = true;
      #  show_program_path = false;
      #};
    };

    yazi = {
      enable = true;
    };
  };

  home.packages = with pkgs; [

    isd
    just

    # compression
    ouch # all-in-one compression utility
    unzip

    # file system
    gdu # tui to explore directory sizes
    tree
    ueberzugpp # for yazi terminal image previews
    fd
    du-dust

    # RIIR
    ripgrep
    bat
    lsd
    
    # encryption
    age
    sops

    # disks
    ncdu
    du-dust

    tealdeer
    fzf
    jq # traverse json
    pandoc # document conversion
    watchexec
    yt-dlp
    neofetch
    trash-cli
    wget
    cmus
    python3
  ];
}
