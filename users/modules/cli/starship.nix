{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      format = ''
        $env_var$username$nix_shell$git_branch$directory$character
      '';
      add_newline = false;
      nix_shell = {
        format = "[\\[$name\\]]($style) ";
      };
      character = {
        success_symbol = "[\\$](bold white)";
        error_symbol = "[?](bold white)";
      };
      directory = {
        truncate_to_repo = true;
        truncation_symbol = "";
        read_only = " (ro)";
        read_only_style = "bold red";
      };
      git_branch = {
        format = "[$branch]($style) ";
      };

      # for distrobox
      env_var.CONTAINER_ID = {
        format = "[distrobox:$env_value ](bold yellow)";
      };
    };
  };
}
