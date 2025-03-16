def binary_search(arr, target):
    stack = [(0, len(arr) - 1)]
    
    while stack:
        left, right = stack.pop()
        
        if left <= right:
            mid = left + (right - left) // 2
            
            if arr[mid] == target:
                return mid
            elif arr[mid] < target:
                stack.append((mid + 1, right))
            else:
                stack.append((left, mid - 1))
    
    return -1  

arr = list(map(int, input("Enter sorted array elements separated by spaces: ").split()))
target = int(input("Enter the target element: "))

result = binary_search(arr, target)

if result != -1:
    print(f"Element found at index {result}")
else:
    print("Element not found")
