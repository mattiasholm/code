# https://docs.python.org/3/library/exceptions.html#Exception
# https://github.com/pulumi/examples/blob/master/azure-py-virtual-data-center/config.py

import math


def num_stats(x):
    if x is not int:
        raise TypeError('Work with Numbers Only')
    if x < 0:
        raise ValueError('Work with Positive Numbers Only')

    print(f'{x} square is {x * x}')
    print(f'{x} square root is {math.sqrt(x)}')

# raise Exception
# raise ValueError
# raise TypeError
