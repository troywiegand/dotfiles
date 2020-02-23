man -Tpdf $(man -k . | rofi -dmenu -theme ~/.cache/wal/colors-rofi-dark | awk '{print $1}') | zathura -
