#!/bin/bash

# drop first line
# remove dictionary rules
# limit to 5 characters ascii only strings
# remove duplicates and sort
# print as a prolog source file
tail --lines=+2 pt_BR.dic | awk -F '/' '{ print $1 }' \
	| grep --perl-regexp '^[a-z]{5}$' | sort --unique \
	| awk '{ print "word5("$0")." }' > words.pl
