export dir=/home/troy/repos/ButlerJunk &&
export subdir=$(ls -t $dir | rofi -dmenu -theme ~/.cache/wal/colors-rofi-dark -p "PDF DIR") && 
file=$(ls -t $dir/$subdir |grep .pdf | rofi -dmenu -theme ~/.cache/wal/colors-rofi-dark -p "PDF" ) && 
zathura "$dir/$subdir/$file"
