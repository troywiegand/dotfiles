text=$(curl -L github.butler.edu | grep License || echo "WIN"  )

while [ "$text" != "WIN" ];
do
	if [ "$text" = "WIN" ]
	then
	notify-send "$text"
	fi
done
