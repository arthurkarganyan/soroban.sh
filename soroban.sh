#!/bin/bash

# Comments:
# The special parameter ‘#’ that expands to the number of positional parameters is updated to reflect the change.

# Initialize our variables
print_help=0
digits=3
sleep_time=3
nums=5
rows=5
usage="Usage: cmd [-h] [-d digits] [-s sleep time] [-n nums] [-r rows] [-m multiply]"
multiply=""

# Parse options
while getopts "hmn:d:s:r:" opt; do
  case ${opt} in
    h ) # process option h for help
      print_help=1 ;;
    d ) # process digits option
      digits=$OPTARG ;;
    n ) # process nums option
      nums=$OPTARG ;;
    s ) # process sleep option
      sleep_time=$OPTARG ;;
    r ) # process rows option
      rows=$OPTARG ;;
    m )
      multiply=t ;;
    \? ) # Invalid option or missing argument
      echo $usage
      exit 1 ;;
  esac
done

# Check if the user asked for help
if [[ $print_help -eq 1 ]]; then
  echo $usage
  echo "-h           Display this help message."
  echo "-d digits    Specify the number of digits."
  echo "-n nums      Specify the number of numbers in a row."
  echo "-r rows      Specify the number of rows."
  echo "-s sleep     Specify sleep time after each number."
  echo "-m multiply  A flag for multiplication training."
  exit 0
fi

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

for (( i=0 ; i<$rows; i++ )) ; do
  if [ -n "$multiply" ]; then
    a=$(random_by_digit_count $digits)
    b=$(random_between_inclusive 2 9)
    sum=$(($a * $b))
    echo "$a*$b"
    say "$a times $b"
  else
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
  fi

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
