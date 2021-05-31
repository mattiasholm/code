#!/usr/bin/env python3

"""Examples of list comprehension in Python"""

# Example 1

list = ["abc-123", "def-456", "ghi-789", "abc-456"]
pattern = "abc"

matching = [s for s in list if pattern in s]

print(matching)


# Example 2

list = ["apa", "aceton", "bacon"]

for x in [x for x in list if "ac" in x]:
    print(x)


# Example 3

list = ["apa", "aceton", "bacon", "bordtennis"]

newlist = [x for x in list if "ac" in x]

print(newlist)


# Example without list comprehension

list = ["apa", "aceton", "bacon"]
newlist = []

for x in list:
    if "ac" in x:
        newlist.append(x)

print(newlist)
