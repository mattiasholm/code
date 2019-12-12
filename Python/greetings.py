#!/usr/bin/env python3


"""greetings.py - a simple Python script to demonstrate how to create "tables" by nesting tuples in a list!"""


def greeting1(people):
    people.append(("Monika", 56))

    for name, age in people:
        print("Hej, mitt namn är {0} och jag är {1} år gammal!\n".format(name, age))


def greeting2(names, ages):
    names.append("Monika")
    ages.append(56)

    zipped = zip(names, ages)
    namelist = list(zipped)

    for x, y in namelist:
        print("Hallå, jag heter {0} och är {1}!\n".format(x, y))


def main():
    greeting1([("Mattias", 28), ("Frank", 52)])

    greeting2(["Mattias", "Frank"], [28, 52])


main()