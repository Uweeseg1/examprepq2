#! /bin/bash
#3a
echo the number of logs with failed communication is:
cat auth-pokemon.log | grep -E '(F|f)ailed' | wc -l

#3b
cat auth-pokemon.log | grep -E '[[:upper:]][a-z]+\.[[:upper:]][a-z]+' | grep -E 'Accepted' | awk '{print $1 " " $2 " "  $8}'

#3c.
#notice there is a log message that appears when a log message is printed twice, i do not know if it means that the person
#attempted to sign in twice and failed or the log double printed. i treated it as a double print as the time is identical
cat auth-pokemon.log | grep -E '[[:upper:]][a-z]+\.[[:upper:]][a-z]+' | grep -E 'password' | grep -E '(F|f)ailed' | awk '{print $8}' | sort |  grep -E '[[:upper:]][a-z]+\.[[:upper:]][a-z]+' | uniq -c | sort -n
