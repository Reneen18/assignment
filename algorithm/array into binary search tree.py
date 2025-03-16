class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def insert_into_bst(root, val):
    if root is None:
        return TreeNode(val)
    if val < root.val:
        root.left = insert_into_bst(root.left, val)
    else:
        root.right = insert_into_bst(root.right, val)
    return root

def array_to_bst(arr):
    if not arr:
        return None
    root = None
    for val in arr:
        root = insert_into_bst(root, val)
    return root

def preorder_traversal(root):
    if root:
        print(root.val, end=" ")
        preorder_traversal(root.left)
        preorder_traversal(root.right)


arr = list(map(int, input("Enter numbers separated by spaces: ").split()))
bst_root = array_to_bst(arr)
preorder_traversal(bst_root)
