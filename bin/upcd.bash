#!/bin/bash
# Author: Jake Askeland, 2014
#         Robert Bosch, LLC

# Changes directories to the first, shallowest sub-directory found with the given name.
function upcd()
{
    # find all sub-directories with the name given on the command-line.
    results=$(find ./ -type d | grep $@$ | grep -v '.hg')
    results_array=( $results )
    num_results=${#results_array[@]}

    if [[ $num_results > 1 ]]; then
        # more than one result was found; choose the shallowest match.
        min_levels=99999
        best_result=""
        for item in ${results_array[*]}
        do
            # make a variable containing only the '/' characters from $item.
            slashes="${item//[^\/]}"

            # count the characters in $slashes.
            levels=${#slashes}

            # if there are fewer levels between us and this item, keep this result as the best.
            if [[ $levels < $min_levels ]]; then
                min_levels=$levels
                best_result=$item
#                multi_best_results=""
#            elif [[ $levels == $min_levels ]]; then
#                multi_best_results=
            fi
        done

        # if there are multiple results at the same level, let the user choose the best.
#        if [[ ${#multi_best_results} > 0 ]]; then
#            select item in ${multi_best_results[*]}
#            do
#                cd $item
#                break
#            done;
#        fi

        # use the best result.
        cd $best_result
    elif [[ $num_results == 1 ]]; then
        # only one result was found, so use it.
        cd $results;
    else
        echo "No such directory exists.";
    fi
}
