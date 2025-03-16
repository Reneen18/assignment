def linear_search(arr, target):
    for i in range(len(arr)):
        if arr[i] == target:
            return i
    return -1  # Element not found

# User input
arr = list(map(int, input("Enter array elements separated by spaces: ").split()))
target = int(input("Enter the target element: "))

result = linear_search(arr, target)

if result != -1:
    print(f"Element found at index {result}")
else:
    print("Element not found")
