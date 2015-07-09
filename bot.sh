#!/bin/bash

cycript -p Germany qd_initbot.cy > /dev/null

interval=45
counter=0

while true; do 
	cycript -p Germany qd_uploadanswers.cy >> bot.log 
	cycript -p Germany qd_reloadgames.cy >> bot.log;
	cycript -p Germany qd_randomgame.cy >> bot.log;
	cycript -p Germany qd_reloadgames.cy >> bot.log;
	cycript -p Germany qd_stats.cy >> bot.log;

	counter=$((counter+1))
	echo "`date`: Completed cycle $counter" >> bot.log
	sleep $interval; 
done
