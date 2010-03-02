#!/bin/bash
#Cleans up bashpodder's mess on the desktop
#by Watchboy

cast=~/Podcasts

cd ~/Podcasts/.bashpodder/incoming/
#clear

mv -v aanq* "$cast/Ask A Ninja/"
mv -v asithappens* "$cast/CBC Radio_ The Best Of As It Happens/"
mv -v current* "$cast/CBC Radio_ The Best Of The Current/"
mv -v LB* "$cast/Linux Basement/"
mv -v MackMurphy* "$cast/Mack Murphy, P.I_/"
mv -v open_source_sex* "$cast/Open Source Sex/"
mv -v punkyradio* "$cast/Punky! Radio/"
mv -v RadioRevolver* "$cast/Radio Revolver/"
mv -v sg_* "$cast/Sculpting God/"
mv -v go_s* "$cast/Sessler's Soapbox/"
mv -v SouthPhillyPaulcast* "$cast/South Philly Paulcast/"
mv -v badAppleLinux* "$cast/The Bad Apples Linux Cast/"
mv -v LinuxActionShow* "$cast/The Linux Action Show/"
mv -v *OGG.ogg "$cast/The Linux Action Show/"
mv -v InDepth* "$cast/The Linux Action Show/In Depth Look"
mv -v Jupiter* "$cast/The Linux Action Show/"
mv -v NewsU* "$cast/The Linux Action Show/"
mv -v mediocre* "$cast/The Mediocre Show/"
mv -v xp200* "$cast/X-Play's Daily Video Podcast/"
mv -v cmdln.net* "$cast/Command Line Podcast/"

#clear
echo -e "\nRemaining files:\n"
ls
