{ ... }:
{
  services = {
    # flatpak stuff: https://github.com/GermanBread/declarative-flatpak/blob/dev/docs/definition.md
    flatpak = {
      enableModule = true;
      remotes = {
        "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
      };
    };
  };
}
