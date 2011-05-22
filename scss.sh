#!/bin/sh

sass="sass -C --scss"

while getopts ":mr:" opt; do
	case $opt in
		(m) sass="$sass -t compressed";;
		(r) sass="$sass -r $OPTARG";;
		(\?) echo "invalid option: -$OPTARG"; exit;;
	esac
done
shift $((OPTIND-1))

awk 'FNR==1 && NR!=1{print "\n"}{print}' $* | \
	$sass | sed 's/@media/\n@media/g'
