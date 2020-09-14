#!/bin/sh

[ $# -lt 3 ] && echo "Usage: $0 <BPM> <left> <right>" && exit 1

dt=$(echo "60/$1" | bc -l)
duty_cycle=0.5
 left=$(echo "$dt/$2*$duty_cycle" | bc -l)
right=$(echo "$dt/$3*$duty_cycle" | bc -l)

while true; do
	for i in $(seq $2); do
		echo left $i
		play -nc2 synth $left  sine 440 remix 1 0 &>/dev/null
	done &
	for i in $(seq $3); do
		echo right $i
		play -nc2 synth $right sine 440 remix 0 1 &>/dev/null
	done &
	sleep $dt
done
