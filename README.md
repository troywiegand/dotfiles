# My Home-Manager Configuration

My dotfiles are managed using [Home Manager](https://github.com/nix-community/home-manager).  All my computers (even my work laptop that utilizes WSL) run Home Manager using nix to specify my configuration files and installed user-space tools and applications.  Similarly, my linux machines run [NixOS](https://wiki.nixos.org/wiki/Overview_of_the_NixOS_Linux_distribution), an operating whose configuration is built on `nix`.  NixOS manages system configuration, like hardware drivers, firewall rules, systemd units, file systems, containers, and desktop environments.  

Together, these tools entirely define my home (and soon cloud) infrastructure and user-space configuration and tools.

## Starting From Scratch

### NixOS

On a new NixOS installation, run this from the home directory.

```
nix-shell -p git
git clone git@github.com:troywiegand/dotfiles.git
cd ~/dotfiles
nixos-rebuild switch --extra-experimental-features flakes \
    --extra-experimental-features nix-command switch --flake .#<host>
```


### Home Manager

In any linux environment with nix installed, run the following from the home directory.

```
nix-shell -p git home-manager
git clone git@github.com:troywiegand/dotfiles.git
cd ~/dotfiles
home-manager --extra-experimental-features flakes \
    --extra-experimental-features nix-command switch --flake .#troy
```

Then run `snrs` to load the system configuration or run `hms` to reload the home-manager configuration.

## Directory Structure

* `hosts`: machine specific NixOS configurations
* `hosts/modules`: NixOS modules
* `users`: user/machine specific home-manager configurations
* `users/modules`: home-manager modules
* `secrets`: contains secret files encrypted with sops-nix

The modules are not polished, nor meant for external use.  They are simply used to break up parts of my configuration and share between hosts and users.

## Hosts and Users

I manage a few host machines on my home network:
* `rumtower`: my gaming and main productivity rig
* `rumprism`: my laptop for light productivity work
* `rumnas`: my home NAS and server
* `rumpi`: my Raspberry Pi 4

Similarly, home-manager configurations:
* `rutrum@rumtower`
* `rutrum@rumprism`
* `rutrum@rumnas`
* `rutrum`: for every other system, including non-nixos systems, like my work laptop running Windows with WSL.  It is also the baseline for the system-specific user configurations to extend upon.
