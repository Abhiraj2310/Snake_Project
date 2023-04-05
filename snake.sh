#!/bin/bash

# Set up the initial variables
WIDTH=80
HEIGHT=40
snake_x=$((WIDTH / 2))
snake_y=$((HEIGHT / 2))
dx=1
dy=0
food_x=$((RANDOM % WIDTH))
food_y=$((RANDOM % HEIGHT))
score=0

# Hide the cursor
tput civis

# Set up the game loop
while true; do
  # Clear the screen
  tput clear

  # Draw the border
  for ((i=0; i<=WIDTH+1; i++)); do
    tput cup 0 $i; echo "#"
    tput cup $((HEIGHT+1)) $i; echo "#"
  done
  for ((i=1; i<=HEIGHT; i++)); do
    tput cup $i 0; echo "#"
    tput cup $i $((WIDTH+1)); echo "#"
  done

  # Draw the snake
  tput cup $snake_y $snake_x; echo "S"

  # Draw the food
  tput cup $food_y $food_x; echo "*"

  # Draw the score
  tput cup $((HEIGHT+2)) 0; echo "Score: $score"

  # Move the snake
  snake_x=$((snake_x + dx))
  snake_y=$((snake_y + dy))

  # Check if the snake hits the border
  if [ $snake_x -eq 0 ] || [ $snake_x -eq $((WIDTH+1)) ] || \
     [ $snake_y -eq 0 ] || [ $snake_y -eq $((HEIGHT+1)) ]; then
    echo "Game over!"
    break
  fi

  # Check if the snake hits the food
  if [ $snake_x -eq $food_x ] && [ $snake_y -eq $food_y ]; then
    score=$((score + 1))
    food_x=$((RANDOM % WIDTH))
    food_y=$((RANDOM % HEIGHT))
  fi

  # Wait for 0.1 seconds
  sleep 0.1

  # Read the keyboard input
  read -s -t 0.2 -n 1 input
  case $input in
    w) dx=0; dy=-1;;
    s) dx=0; dy=1;;
    a) dx=-1; dy=0;;
    d) dx=1; dy=0;;
  esac
done

# Show the cursor
tput cnorm
