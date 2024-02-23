#!/bin/bash

# Comments:
# The special parameter ‘#’ that expands to the number of positional parameters is updated to reflect the change.

# Initialize our variables
print_help=0
digits=3
sleep_time=3
nums=5

# Parse options
while getopts "hn:d:s:" opt; do
  case ${opt} in
    h ) # process option h for help
      print_help=1 ;;
    d ) # process digits option
      digits=$OPTARG ;;
    n ) # process nums option
      nums=$OPTARG ;;
    s ) # process sleep option
      sleep_time=$OPTARG ;;
    \? ) # Invalid option or missing argument
      echo "Usage: cmd [-h] [-d digits] [-s sleep time]"
      exit 1 ;;
  esac
done

# Check if the user asked for help
if [[ $print_help -eq 1 ]]; then
  echo "Usage: cmd [-h] [-d digits] [-s sleep time]"
  echo "-h        Display this help message."
  echo "-d digits Specify the number of digits."
  echo "-n nums   Specify the number of numbers."
  echo "-s sleep  Specify sleep time after each number."
  exit 0
fi

soroban() {
    # -n numbers, default = 10
    # -d digits, default = 1
    # generate 10 numbers with a number of digits from the argument
    # random from 10 to 100
    # if > 0 replace with `plus`
    # else replace with minus
    # join with ", "
    # `say "minus 5, plus 10"`
    # the sum can't never be less than 0 at any given moment
    # ask for input
    echo ""
}

# Usage:
#   `random_between_inclusive 10 99`
random_between_inclusive() {
    lower=$1

    upper=$2

    # the number of numbers in the range of possible returns
    range_count=$(( upper - lower + 1 ))

    # Each time $RANDOM is referenced, it expands to a random integer between 0 and 32767.
    x=$RANDOM

    # calculation
    x=$(( x % range_count + $lower ))

    # return the value
    echo $x
}

# Usage:
#   `random_by_digit_count 2`
random_by_digit_count() {
    mod=$(( 10 ** $1 - 1 ))

    mod_prev=$(( 10 ** ($1 - 1) ))

    # This returns the value
    echo $(random_between_inclusive $mod_prev $mod)
}

tries=5

for (( i=1 ; i<$tries; i++ )) ; do
    sum=$(random_by_digit_count $digits)
    echo " $sum"
    $(say $sum)
    sleep $sleep_time

    for (( j=1 ; j<$nums; j++ )) ; do
        tmp=$(random_by_digit_count $digits)
        echo +$tmp
        $(say "+$tmp")
        sleep $sleep_time
        sum=$(( $sum + $tmp ))
    done

    say "answer"
    echo ""
    read -a answer -p "Answer: " # read input into $answer

    if [[ $answer == q ]] ; then
        exit 0
    fi

    # Check the sum
    if [[ $answer == $sum ]] ; then
        say "yes"
        echo "correct";
    else
        say "no"
        echo ":(";
    fi
    echo ""
done
