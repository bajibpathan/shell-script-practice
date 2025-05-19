#!/bin/bash

MOVIES=("Court" "HIT3" "PUSHPA2" "Thandel")

echo "First Movie: ${MOVIES[0]}"
echo "Third Movie: ${MOVIES[2]}"
echo "Fourth Movie: ${MOVIES[3]}"

echo "All Movies: ${MOVIES[@]}"
echo "Total Movies: ${#MOVIES[@]}"