#!/usr/bin/env python3

"""globalvariable.py - a simple Python program to demonstrate local versus global variables!"""

def function():
    global x #Try and comment out this line
    x = "awesome"

x = "shit"

function()

print("Python is {0}!".format(x))
