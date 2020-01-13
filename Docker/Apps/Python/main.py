#!/usr/bin/env python3

"""A very simple Python app for demonstrating running Python in a Docker container"""

def greeting(name):

#    print("Hello world!")
    print("Hello {0}!".format(name))

def main():
    greeting("Mattias")
 
if __name__ == "__main__":
    main()
