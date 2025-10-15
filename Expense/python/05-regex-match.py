import re

text = "The quick brown fox"
pattern = r"quick"

result = re.match(pattern, text)
if result:
    print("Match found:", result.group())
else:
    print("No match")