#!/bin/bash

# A
number_of_processes="${1}"
# whoami returns the username that invoked the script
curr_user=$(whoami)
echo "$ ! is" $($!)  
echo "I'm ${curr_user}"
if ! [[ $(echo $1 | sed -En 's/(^[1-9]+$)/\1/p') -gt 0 ]] ; then echo we need 1 argument of an integer; exit 1; fi 
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi
# this checks the user id -u returns a number represending the user, if you do sudo id -u you get 0 and user name is root
# B
curr_process=0
proccesses_list=()
while [[ ${curr_process} -lt ${number_of_processes} ]]; do
       sleep 3600 &
       echo adding $! to prcess list
       processes_list+=($!)
       echo  
       curr_process=$(( ${curr_process} + 1 ))
done
# C
processes_from_ps=$(ps axo comm,pid,user | grep "^sleep.*${curr_user}" | awk '{print $2}')
# this is a code that creates an output of all the processes created in the loop above under the name sleep	

# Calculate the diff between two arrays
echo ${processes_list[@]} ----  ${processes_from_ps[@]} is the line of processs
echo ${processes_list[@]} ${processes_from_ps[@]} | tr ' ' '\n' | sort | uniq -u
echo "Killing processes ${processes_list[@]}"
for proc in ${processes_list[@]}; do
	echo killing process $proc
	kill -9 $proc
done

### we have an error here, it only kills the fist process in the list

# Bonus D
adduser linuxtestuser --gecos "" --disabled-password &>/dev/null || true
curr_process=0
while [[ ${curr_process} -lt ${number_of_processes} ]]; do
       su linuxtestuser -c "echo 'this is a test'"
       curr_process=$(( ${curr_process} + 1 ))
       echo ${curr_process}
done

echo "Done"
