#!/bin/bash

set -eu

# default scrot arguments:
# freeze, include mouse pointer, maximum quality & no compression
SCROTARGS=(-f -p -q 100 -Z 0)
# file will be saved as PNG on your screenshots directory with the name
# Screenshot_YYYY-MM-DD@HH:MM:SS[ AM/PM].png
FN_FORMAT=("$HOME/Pictures/Screenshots/Screenshot_%F@%R:%S.png")
# use xclip as our clipboard manager
CLIP_OPTS=("xclip -selection clipboard -t image/png -i \$f")

hprint() { # 'highlighted print' :)
	# highlight the first chunk of the
	# message and leave the rest unaltered
	tput bold
	printf "$1"
	tput sgr0

	printf "${*:2}"
}

for i in $@; do
	case $i in
		"clipboard" | "c") # saving to clipboard?
			SCROTARGS+=(-e "${CLIP_OPTS[@]}")
			;;

		"file" | "f") # saving to a file?
			SCROTARGS+=(-F "${FN_FORMAT[@]}")
			;;
		
		"select" | "s") # screenshooting an area?
			SCROTARGS+=(-s)
			;;

		"window" | "w") # screenshooting active window?
			SCROTARGS+=(-u)
			;;

		"screen" | "S") # screenshooting the whole screen?
			# this is scrot's default, nothing needs
			# to be done here
			;;

		"version" | "v")
			hprint "X.Shot version 1.0a" \
				", running with" \
				"\n$(scrot -v)." \
				"\nWritten by ruby R53 on August 2025.\n"
			;;

		"help" | "h" | *) # user entered an invalid parameter?
			hprint "Usage: " "$0 <outtype> <seltype>\n"
			hprint "<outtype> " "is one of:" \
				"\n(c)lipboard - save to clipboard" \
				"\n(f)ile      - save to file, specified by \$FN_FORMAT\n"
			hprint "<seltype> " "is one of:" \
				"\n(s)elect    - take a screenshot by selecting an area" \
				"\n(w)indow    - take a screenshot of the active window" \
				"\n(S)creen    - take a full screen shot\n"
			hprint "Miscellaneous:" \
				"\n(h)elp      - shows this help screen and exit" \
				"\n(v)ersion   - shows this script + scrot's version" \
				"\n              and exit\n"

			[[ $1 != "help" ]] && [[ $1 != "h" ]] && exit 1
			;;
	esac
done

# and finally, run the requested command
# altogether
scrot "${SCROTARGS[@]}"

# then, clean stuff up if we're saving to the
# clipboard only
[[ -z $(echo $@ | grep file) ]] && rm $(pwd)/*_scrot.png
# this allows the user to combine both
# 'file' and 'clipboard' so that they
# can save to 2 locations at once
