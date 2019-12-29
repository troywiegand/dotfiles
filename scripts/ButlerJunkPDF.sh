export dir=/home/troy/repos/ButlerJunk
export subdir=$(ls $dir | dmenu ) && ls $dir/$subdir |grep .pdf | dmenu | xargs -r echo "$dir/$subdir/" | sed 's/ //g' | xargs -r zathura
