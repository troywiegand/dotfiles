~/dotfiles/scripts/kaschcow Starting CW.sh

(curl https://www.cwtv.com/shows/arrow/ | grep -B 6 "NEW \!" | head -n 1 | sed 's/\//\n\//' | sed 's/\(^\/shows[^ "]*\)\(.*\)/\1/g' | tail -n 1 | xargs -I{} echo https://www.cwtv.com\{\} | xargs youtube-dl -o "~/Videos/AR/%(title)s-%(id)s.%(ext)s" >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Arrow episode $(ls -t ~/Videos/AR | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow THIS EPISODE HAS FAILED THIS CITY 

(curl https://www.cwtv.com/shows/the-flash/ | grep -B 6 "NEW \!" | head -n 1 | sed 's/\//\n\//' | sed 's/\(^\/shows[^ "]*\)\(.*\)/\1/g' | tail -n 1 | xargs -I{} echo https://www.cwtv.com\{\} | xargs youtube-dl -o "~/Videos/FL/%(title)s-%(id)s.%(ext)s"  >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Flash episode $(ls -t ~/Videos/FL | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow "You weren't fast enough"

(curl https://www.cwtv.com/shows/supergirl/ | grep -B 6 "NEW \!" | head -n 1 | sed 's/\//\n\//' | sed 's/\(^\/shows[^ "]*\)\(.*\)/\1/g' | tail -n 1 | xargs -I{} echo https://www.cwtv.com\{\} | xargs youtube-dl -o "~/Videos/SG/%(title)s-%(id)s.%(ext)s" >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Supergirl episode $(ls -t ~/Videos/SG | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow This episode is my kryptonite 

(curl https://www.cwtv.com/shows/batwoman/ | grep -B 6 "NEW \!" | head -n 1 | sed 's/\//\n\//' | sed 's/\(^\/shows[^ "]*\)\(.*\)/\1/g' | tail -n 1 | xargs -I{} echo https://www.cwtv.com\{\} | xargs youtube-dl -o "~/Videos/BW/%(title)s-%(id)s.%(ext)s" >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Batwoman episode $(ls -t ~/Videos/BW | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow This episode is driving me bats

(curl https://www.cwtv.com/shows/dcs-legends-of-tomorrow/ | grep -B 6 "NEW \!" | head -n 1 | sed 's/\//\n\//' | sed 's/\(^\/shows[^ "]*\)\(.*\)/\1/g' | tail -n 1 | xargs -I{} echo https://www.cwtv.com\{\} | xargs youtube-dl -o "~/Videos/LT/%(title)s-%(id)s.%(ext)s"  >/dev/null 2>&1 && ~/dotfiles/scripts/kaschcow The Legends of Tomorrow episode $(ls -t ~/Videos/LT | head -n 1 | awk -F'-' '{print $1}') is installed. ) || ~/dotfiles/scripts/kaschcow This episode is stuck in time time vortex!

~/dotfiles/scripts/kaschcow Finishing CW.sh

