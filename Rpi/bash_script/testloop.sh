#!/bin/bash

mylist="camille marie alice bob dave"

echo "these people are my friend: $mylist"

for friend in $mylist
do 
	echo "hey $friend!"
done
