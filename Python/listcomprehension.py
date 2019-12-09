#!/usr/bin/env python3

list = ["abc-123", "def-456", "ghi-789", "abc-456"]
pattern = "abc"

matching = [s for s in list if pattern in s]

print(matching)