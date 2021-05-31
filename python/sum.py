#!/usr/bin/env python3

"""sum.py - a simple Python program that takes two integers as input and returns the sum!"""


def func(x, y):
    return x + y


x = int(input("Enter a number: "))
y = int(input("Enter another number: "))

sum = func(x, y)

print("The sum of the numbers {0} and {1} is {2}".format(x, y, sum))
