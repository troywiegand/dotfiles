man -Tpdf $(man -k . | dmenu -l 30 | awk '{print $1}') | zathura -
