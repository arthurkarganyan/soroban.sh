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

# Accepts just one parameter indicating the number of digits of a random number to generate
random() {
    # Each time $RANDOM is referenced, it expands to a random integer between 0 and 32767.
    x=$RANDOM

    mod=$(( 10 ** $1 ))

    # TODO should be between 10 and 99 inclusive
    # x becomes number between 1 and 99 inclusive
    x=$(( $x % (mod - 1) + 1))

    # This returns the value
    echo $x
}

res=`random 2`
echo $res
