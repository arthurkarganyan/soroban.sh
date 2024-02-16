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

# The special parameter ‘#’ that expands to the number of positional parameters is updated to reflect the change.
random() {
    return "a"
    # $RANDOM
}

# random()
# echo $RANDOM # Each time this parameter is referenced, it expands to a random integer between 0 and 32767.
