# Cheat Sheet - Python

<br>

## Python shebang:
```shell
#!/usr/bin/env python3
```

## Check installed Python version:
```shell
python3 --version
```

## Run Python:
```shell
python3
```

## Clear screen in Python:
`Mac` Cmd+L

`Windows` Ctrl+L

## Exit Python:
```python
exit()
```

<br><br>

## Print to standard output:
```python
print("Message")
```

## Add a single-line comment:
```python
#Comment
```

## Add a multi-line comment:
```python
"""
Multi-line
Comment
"""
```

## Assign a variable:
```python
x = 1
```

## Assign multiple variables at once:
```python
x, y, z = 1, 2, 3
```

## Assign the same value to multiple variables:
```python
x = y = z = 1
```

## Declare a variable as global, instead of local:
```python
global x
```

<br><br>

## Get the first character of a string (or the first element of an array):
```python
print(a[0])
```

## Slicing - Get a substring (start position included, end position excluded):
```python
print(a[2:5])
```

## Slicing - Use negative indexes to start the slice from the end of the string:
```python
print(b[-5:-2])
```

## Get length of string (or array):
```python
len(a)
```

<br><br>

## Built-in data types:

| Category       | Types                              |
| -------------- | ---------------------------------- |
| Text Type      | `str`                              |
| Numeric Types  | `int`, `float`, `complex`          |
| Sequence Types | `list`, `tuple`, `range`           |
| Mapping Type   | `dict`                             |
| Set Types      | `set`, `frozenset`                 |
| Boolean Type   | `bool`                             |
| Binary Types   | `bytes`, `bytearray`, `memoryview` |

## Get data type:
```python
type(x)
```

## Cast a variable:
```python
x = int(1E3)
```

## Generate a random number:
```python
import random
print(random.randrange(1,10))
```

<br><br>

## Proper structure of a Python program:
```python
#!/usr/bin/env python3

"""program.py - a short description of the program - called a docstring"""

# Here comes your imports
 
# Here comes your (few) global variables
 
# Here comes your class definitions
 
# Here comes your function definitions
 
def main():
	pass
 
if __name__ == "__main__":
	main()
```

<br><br>

# OBS: Eventuellt bättre att göra allt i tabellform, så man slipper allt scrollande? Tänk mer som ett lexikon, bättre att skapa exempelskript för att visa mer exakt hur något används!



<br><br>

| Method       | Description                                                   |
| ------------ | ------------------------------------------------------------- |
| len()        | Returns length of a string or array                           |
| strip()      | Removes trailing whitespace                                   |
| lower()      | Returns string in lower-case                                  |
| upper()      | Returns string in upper-case                                  |
| title()      | Returns string in title-case                                  |
| capitalize() | Returns string capitalized                                    |
| replace()    | Replaces a string with another string                         |
| in           | Returns a bool whether substring exists in string             |
| not          | Negation                                                      |
| +            | Addition or string concatenation                              |
| -            | Subtraction                                                   |
| *            | Multiplication                                                |
| /            | Division                                                      |
| **           | Exponentiation                                                |
| \            | Escape character                                              |
| \n           | New line                                                      |
| \t           | Tab                                                           |
| count()      | Returns the number of times a substring appears in a string   |
| endswith()   | Returns a bool whether a string ends with a certain substring |
| find()       | Returns the position of a substring in a string               |
| format()     | Format string                                                 |

<br><br>

# FORTSÄTT HÄR:
https://www.w3schools.com/python/python_strings.asp