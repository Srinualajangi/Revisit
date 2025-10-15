import re

text = " The quick red fox jumps over the lazy red dog"
pattern = r"red"

replacement = "white"
new_text = re.sub(pattern, replacement, text)
print("Modified text:", new_text)