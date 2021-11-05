#!/bin/bash

read -p "input the operator: " operator
read -p "input first number: " nb1
read -p "input second number: " nb2

let sum="$nb1 $operator $nb2"
echo "$sum"

number1=5
number2=100

sum=$(($number1 + $number2))
sum=$(expr $number1 + $number2)

echo "the sum is: $sum"
