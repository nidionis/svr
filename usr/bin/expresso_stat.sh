#!/usr/bin/bash

FILE=$1

if [ -z "$FILE" ]; then
	echo "Usage: $0 FILE"
	exit 1
fi
sed "s/[a-zA-Z€]//g" "$FILE" | sed "s/-/0/g" | sed "s/,/./g" | gawk '
{
	if (NF < 7) next

	BUY_IN = $3 + 0.0
	WON    = $5 + 0.0
	PRIZE  = $7 + 0.0

	key = BUY_IN

	total_cost[key] += BUY_IN
	total_won[key]  += WON
	total_prize[key] += PRIZE
	nb_game[key]++
	hot_game = 0

	if (PRIZE >= BUY_IN * 3) {
		hot_game = 1
		total_hotgame[key]++
	}
	if ($4 == 1) {
		game_won[key]++
		if (hot_game) hot_game_won[key]++
	}
}

END {
	printf "%10s %6s %6s %9s %9s %9s %9s %9s %8s %8s\n", \
	       "BUY_IN", "Games", "Wins", "WinRate", "HotWin%", "RealRate", "Spent", "Won", "Net", "Marge"
	for (key in nb_game) {
		if (total_cost[key] == 0) continue

		ratio = (game_won[key] / nb_game[key]) * 300
		real_winrate = (total_won[key] / total_cost[key]) * 100
		hotrate = (total_hotgame[key] > 0) ? (300 * hot_game_won[key] / total_hotgame[key]) : 0
		net = total_won[key] - total_cost[key]
		hotness = (total_prize[key] / total_cost[key]) * 100 / 3

		printf "%10.2f %6d %6d %8.2f%% %8.2f%% %8.2f%% %8.2f€ %8.2f€ %7.2f€ %7.2f\n", \
		       key, nb_game[key], game_won[key], ratio, hotrate, real_winrate, \
		       total_cost[key], total_won[key], net, hotness
	}
}'


#sed "s/[a-zA-Z€]//g" "$FILE" | sed "s/-/0/g" | sed "s/,/./g" | gawk '
#{
#	if (NF < 7) next
#
#	BUY_IN = $3 + 0.0
#	WON  = $5 + 0.0
#	PRIZE = $7 + 0.0
#
#	TOTAL_COST += BUY_IN
#	TOTAL_WON += WON
#	TOTAL_PRIZE += PRIZE
#	NB_GAME++
#	HOT_GAME = 0
#
#	if ($PRIZE >= $BUY_IN) HOT_GAME = 1
#	if ($PRIZE >= $BUY_IN) TOTAL_HOTGAME++
#	if ($4 == 1) GAME_WON++
#	if (HOT_GAME && $4 == 1) HOT_GAME_WON++
#}
#END {
#	if (NB_GAME == 0 || TOTAL_COST == 0) {
#		print "No valid data."
#		exit
#	}
#	RATIO = (GAME_WON / NB_GAME) * 300
#	REAL_WINRATE = (TOTAL_WON / TOTAL_COST) * 100
#	NET = TOTAL_WON - TOTAL_COST
#	HOTNESS = (TOTAL_PRIZE / TOTAL_COST) * 100 / 3
#
#	printf "Games: %d\n", NB_GAME
#	printf "Wins: %d\n", GAME_WON
#	printf "WinRate: %.2f%%\n", RATIO
#	printf "hot games WinRate: %.2f%%\n", 300 *HOT_GAME_WON / TOTAL_HOTGAME
#	printf "Real win rate: %.2f%%\n", REAL_WINRATE
#	printf "Spent: %.2f€\n", TOTAL_COST
#	printf "Won: %.2f€\n", TOTAL_WON
#	printf "Net: %.2f€\n", NET
#	printf "Marge site: %.2f\n", HOTNESS
#}'

