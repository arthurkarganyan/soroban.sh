#!/bin/bash

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

nums=4
digits=3
tries=5
sleep_time=3

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

    echo ""
    read -a answer -p "Answer: " # read input into $answer

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
