export dir=/home/troy/repos/ButlerJunk &&
export subdir=$(ls $dir | dmenu ) && 
file=$(ls $dir/$subdir |grep .pdf | dmenu ) && 
zathura "$dir/$subdir/$file"
