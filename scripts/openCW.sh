ls -t Videos/CW/ | dmenu -i -l 10 -p "What show?" | xargs -I {} echo "Videos/CW/{}" | tee /tmp/show.txt  | xargs -I {} ls -tR /home/troy/{} | grep .mp4 | rev | cut -c 5- | rev |  sed -e 's,_, ,g'| dmenu -i -l 10 -p "What episode?" | sed -e 's, ,_,g' >> /tmp/show.txt;
head -1 /tmp/show.txt | xargs -I {} echo "/home/troy/{}/`tail -1 /tmp/show.txt`" | xargs -I {} mpv {}.mp4
