#!/bin/sh

[ $# -lt 3 ] && echo "Usage: $0 <BPM> <left> <right>" && exit 1

dt=$(echo "60/$1" | bc -l)
pulse=0.1
wait=$(echo 1-$pulse | bc -l)
left_pulse=$(echo "$dt/$2*$pulse" | bc -l)
left_wait=$(echo "$dt/$2*$wait" | bc -l)
right_pulse=$(echo "$dt/$3*$pulse" | bc -l)
right_wait=$(echo "$dt/$3*$wait" | bc -l)

while true; do
	for i in $(seq $2); do
		play -nc2 synth $left_pulse sine 440 remix 1 0 &>/dev/null
		sleep $left_wait
	done &
	for i in $(seq $3); do
		play -nc2 synth $right_pulse sine 440 remix 0 1 &>/dev/null
		sleep $right_wait
	done &
	wait
done
