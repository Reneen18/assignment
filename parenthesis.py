def are_parentheses_balanced(s):
    stack = []
    for char in s:
        if char == '(':
            stack.append(char)
        elif char == ')':
            if not stack:  # Extra closing parenthesis detected
                return False
            stack.pop()
    return len(stack) == 0  # If stack is empty, parentheses are balanced

user_input = input("Enter a string with parentheses: ")
result = are_parentheses_balanced(user_input)
print("Output:", result)