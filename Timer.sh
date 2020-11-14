#!/bin/bash

# Timer
# Script by MR
# For contact:  a.m.rasouli.n@gmail.com
# Script is available on github
# GITHUB: https://github.com/1MahdiR/Timer.sh
#

HOURS=0
MINS=0
SECENDS=0

ARGS=${@}

function contains () {

  local list=$1
  local target=$2

  for item in ${list[@]} ; do
    if [[ $item = $target ]]; then
      echo "0"
      return
    fi
  done

  echo "1"
  return
}


output=""
function handleArgs () {

	Arg=$@
  Opt=( '-h' '-m' '-s' )


  #
  # display version
  #
	if [[ `contains $Arg "--version"` = "0" ]]; then
		tput bold
		echo -e "
Timer 1.02"
		tput sgr0
		echo -e "
Script is available on github.
GITHUB: https://github.com/1MahdiR/Timer.sh
"

		exit 0
		return
	fi


  #
  # display help
  #
	if [[ `contains $Arg "--help"` = "0" ]]; then
		echo -e "
Usage: Timer [OPTION]...
Start and show a timer with specified OPTION(s).\n
At least one OPTION has to be specified.\n
Options:
\t-h\t\tSet the \"hours\" for timer.
\t-m\t\tSet the \"minutes\" for timer.
\t-s\t\tSet the \"seconds\" for timer.
\t--help\t\tDisplay this help and exit.
\t--version\tOutput version information and exit.\n
Examples:
./Timer.sh -h 1 -m 10 -s 5\t   Set a timer for 1 hour, 10 minutes and 5 secends.

				 "

		exit 0
	fi

}


handleArgs $ARGS
if [[ ${output::6} = "Error_" ]]; then
  echo -e $output >&2
  exit 1
fi


#
# getting arguments
#
flag=""
for i in ${ARGS[@]}; do

  if [[ $i = "-h" ]]; then
    flag="hour"
  elif [[ $i = "-m" ]]; then
    flag="minute"
  elif [[ $i = "-s" ]]; then
    flag="secend"
  fi

  if [[ $flag = "hour" ]]; then
    HOURS=$i
  elif [[ $flag = "minute" ]]; then
    MINS=$i
  elif [[ $flag = "secend" ]]; then
    SECENDS=$i
  fi

done

#echo $HOURS:${MINS}:$SECENDS

#
# printing the clock
#
echo -ne "\n\t"
while [ $HOURS -ne 0 -o $MINS -ne 0 -o $SECENDS -ne 0 ]; do
     echo -ne " -> $(if [ $HOURS -lt 10 ];then echo -n "0"; fi)$HOURS:$(if [ $MINS -lt 10 ];then echo -n "0"; fi)$MINS:$(if [ $SECENDS -lt 10 ];then echo -n "0"; fi)$SECENDS\r\t"
     sleep 0.995

     if [ ! $SECENDS -eq 0 ]; then
          SECENDS=$((SECENDS-1))
     elif [ ! $MINS -eq 0 ]; then
          MINS=$((MINS-1))
          SECENDS=59
     elif [ ! $HOURS -eq 0 ]; then
          HOURS=$((HOURS-1))
          MINS=59
          SECENDS=59
     fi

done

#
# Time's up
#
echo -ne " -> $(if [ $HOURS -lt 10 ];then echo -n "0"; fi)$HOURS:$(if [ $MINS -lt 10 ];then echo -n "0"; fi)$MINS:$(if [ $SECENDS -lt 10 ];then echo -n "0"; fi)$SECENDS\r\t"
echo -e "\n"
tput setaf 1
tput bold
echo -e "\t   TIME'S UP!"
tput sgr0

#
# making a little bit noise for the alarm
#
while true; do
     sleep 0.2
     echo -ne "\a"
     sleep 0.2
     echo -ne "\a"
     sleep 0.4
     echo -ne "\a"
     sleep 0.2
     echo -ne "\a"
     sleep 0.2
     echo -ne "\a"
     sleep 0.35
     echo -ne "\a"
     sleep 0.2

done

exit 0
