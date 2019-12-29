(youtube-dl -o "~/Videos/AR/%(title)s-%(id)s.%(ext)s" https://www.cwtv.com/shows/arrow >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Arrow episode $(ls -t ~/Videos/AR | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow THIS EPISODE HAS FAILED THIS CITY 

(youtube-dl -o "~/Videos/FL/%(title)s-%(id)s.%(ext)s" https://www.cwtv.com/shows/the-flash >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Flash episode $(ls -t ~/Videos/FL | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow "You weren't fast enough"

(youtube-dl -o "~/Videos/SG/%(title)s-%(id)s.%(ext)s" https://www.cwtv.com/shows/supergirl >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Supergirl episode $(ls -t ~/Videos/SG | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow This episode is my kryptonite 

(youtube-dl -o "~/Videos/BW/%(title)s-%(id)s.%(ext)s" https://www.cwtv.com/shows/batwoman >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Batwoman episode $(ls -t ~/Videos/BW | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow This episode is driving me bats
