wget -q http://dynamic.xkcd.com/comic/random/ -O - | grep -Eo http://imgs.xkcd.com/comics/.*png | wget -q -i - -O - | display
