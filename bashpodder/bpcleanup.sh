#!/bin/bash
#Cleans up bashpodder's mess
#by Watchboy

cast=/media/IPOD/02\ Podcasts

cd /media/IPOD/.bashpodder/incoming/
#clear

mv aanq* "$cast/Ask A Ninja/"
mv asithappens* "$cast/CBC Radio_ The Best Of As It Happens/"
mv current* "$cast/CBC Radio_ The Best Of The Current/"
mv LB* "$cast/Linux Basement/"
mv MackMurphy* "$cast/Mack Murphy, P.I_/"
mv open_source_sex* "$cast/Open Source Sex/"
mv punkyradio* "$cast/Punky! Radio/"
mv RadioRevolver* "$cast/Radio Revolver/"
mv sg_* "$cast/Sculpting God/"
mv go_s* "$cast/Sessler's Soapbox/"
mv SouthPhillyPaulcast* "$cast/South Philly Paulcast/"
mv badAppleLinux* "$cast/The Bad Apples Linux Cast/"
mv LinuxActionShow* "$cast/The Linux Action Show/"
mv *OGG.ogg "$cast/The Linux Action Show/"
mv InDepth* "$cast/The Linux Action Show/In Depth Look"
mv Jupiter* "$cast/The Linux Action Show/"
mv NewsU* "$cast/The Linux Action Show/"
mv mediocre* "$cast/The Mediocre Show/"
mv xp200* "$cast/X-Play's Daily Video Podcast/"
mv cmdln.net* "$cast/Command Line Podcast/"

#clear
echo -e "\nRemaining files:\n"
ls
