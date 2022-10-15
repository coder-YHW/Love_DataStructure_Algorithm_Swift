//
//  BinaryTree.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

// 注意闭包的写法: 1、any小写 2、协议不要: 3、多个协议用&隔开
typealias TreeVisitor = ((any Comparable) -> ())


/// 二叉树
class BinaryTree<E: Comparable> {

    // MARK: - 属性
    /// 元素数量
    var count = 0
    /// 根节点
    var root: TreeNode<E>?
    
    
    // MARK: - 接口方法
    /**是否为空*/
    func size() -> Int {
        return count
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return count == 0
    }
    
    /// 清除所有节点
    func clear() {
        root = nil
        count = 0
    }
}


// MARK: - 遍历二叉树
extension BinaryTree {
    
    /// 前序遍历(递归) - （root->左子树->右子树）
    public func preOrder(treeVisitor: ((E?) -> ())?) {
        preOrder(node: root, treeVisitor: treeVisitor)
    }
    
    fileprivate func preOrder(node: TreeNode<E>?, treeVisitor: ((E?) -> ())? = nil) {
        
        if let node {
//            print(node)
            if let treeVisitor {
                treeVisitor(node.element)
            }else {
                print(node)
            }
            
            preOrder(node: node.left, treeVisitor: treeVisitor)
            preOrder(node: node.right, treeVisitor: treeVisitor)
        }
    }
    
    /// 中序遍历(递归) - （左子树->root->右子树）
    public func inOrder(treeVisitor: ((E?) -> ())?) {
        inOrder(node: root, treeVisitor: treeVisitor)
    }
    
    fileprivate func inOrder(node: TreeNode<E>?, treeVisitor: ((E?) -> ())? = nil) {
        
        if let node {
            inOrder(node: node.left, treeVisitor: treeVisitor)
            
//            print(node)
            if let treeVisitor {
                treeVisitor(node.element)
            }else {
                print(node)
            }
            
            inOrder(node: node.right, treeVisitor: treeVisitor)
        }
    }
    
    /// 前序遍历(递归) - （左子树->右子树->root）
    public func postOrder(treeVisitor: ((E?) -> ())?) {
        postOrder(node: root, treeVisitor: treeVisitor)
    }
    
    fileprivate func postOrder(node: TreeNode<E>?, treeVisitor: ((E?) -> ())? = nil) {
        
        if let node {
            postOrder(node: node.left, treeVisitor: treeVisitor)
            postOrder(node: node.right, treeVisitor: treeVisitor)
            
//            print(node)
            if let treeVisitor {
                treeVisitor(node.element)
            }else {
                print(node)
            }
        }
    }
    
    /// 层序遍历(迭代)
    func levelOrder(treeVisitor: ((E?) -> ())? = nil)  {

        if root == nil {
            return
        }
        
        let queue = SingleQueue<TreeNode<E>>()
        queue.enQueue(root) // // 0、根节点入队
        
        while !queue.isEmpty() {
            
            guard let node = queue.deQueue() else {
                return
            }
//            print(node)
            if let treeVisitor {
                treeVisitor(node.element)
            }else {
                print(node)
            }
            
            if let left = node.left { // 1、左子节点入队
                queue.enQueue(left)
            }
            
            if let right = node.right { // 2、右子节点入队
                queue.enQueue(right)
            }
        }
    }
    
    /// 前序遍历(迭代)
    func preOrderForEach() {
        
        if root == nil {
            return
        }
        
        let stack = Statck<TreeNode<E>>()
        stack.push(root)

        while !stack.isEmpty() {
            
            let node = stack.pop()
            print(node!)

            if let right = node?.right {
                stack.push(right)
            }
            
            if let left = node?.left {
                stack.push(left)
            }
        }
    }

    /// 中序遍历(迭代)
    func infixOrderForEach() {
        
        if root == nil {
            return
        }
        
        var node = root
        let stack = Statck<TreeNode<E>>()
        
        while !stack.isEmpty() || node != nil {
            
            while node != nil {
                stack.push(node)
                node = node?.left
            }

            let peek = stack.pop()
            print(peek!)
            
            node = peek?.right
        }
    }

    /// 后序遍历(迭代)
    func epilogueForEach() {
        
        if root == nil {
            return
        }
        
        var node = root
        var currNode: TreeNode<E>?

        let stack = Statck<TreeNode<E>>()
        stack.push(node)

        while !stack.isEmpty() {
            let peek = stack.peek()
            let isLeaf = peek?.isLeaf() ?? false

            // 栈顶节点是否是椰子节点, 上一次访问节点是否是栈顶节点的子节点
            if isLeaf || currNode?.parent == peek {
                node = stack.pop()
                currNode = node
                print(node!)
                
            } else {
                node = peek
                if let right = node?.right {
                    stack.push(right)
                }
                if let left = node?.left {
                    stack.push(left)
                }
            }
        }
    }
}

// MARK: - 翻转二叉树
extension BinaryTree {
    
    /// 前序遍历(递归) - （root->左子树->右子树）
    public func preOrderInvertTree() {
        preOrder(node: root)
    }
    
    fileprivate func preOrderInvertTree(node: TreeNode<E>?) {
        
        if let node {
            print(node)
            let temNode = node.left
            node.left = node.right
            node.right = temNode
            
            preOrder(node: node.left)
            preOrder(node: node.right)
        }
    }
    
    /// 中序遍历(递归) - （左子树->root->右子树）
    public func inOrderInvertTree() {
        inOrder(node: root)
    }
    
    fileprivate func inOrderInvertTree(node: TreeNode<E>?) {
        
        if let node {
            inOrder(node: node.left)
            
            print(node)
            let temNode = node.left
            node.left = node.right
            node.right = temNode
            
            // 注意 中序遍历：翻转之后的左子树才是翻转之前的右子树
            inOrder(node: node.left)
        }
    }
    
    /// 前序遍历(递归) - （左子树->右子树->root）
    public func postOrderInvertTree() {
        postOrder(node: root)
    }
    
    fileprivate func postOrderInvertTree(node: TreeNode<E>?) {
        
        if let node {
            postOrder(node: node.left)
            postOrder(node: node.right)
            
            print(node)
            let temNode = node.left
            node.left = node.right
            node.right = temNode
        }
    }
    
    /// 层序遍历(迭代)
    public func levelOrderInvertTree()  {
        
        if root == nil {
            return
        }
        
        let queue = SingleQueue<TreeNode<E>>()
        queue.enQueue(root) // // 0、根节点入队
        
        while !queue.isEmpty() {
            
            let node = queue.deQueue()
            print(node!)
            let temNode = node?.left
            node?.left = node?.right
            node?.right = temNode
            
            if let left = node?.left { // 1、左子节点入队
                queue.enQueue(left)
            }
            
            if let right = node?.right { // 2、右子节点入队
                queue.enQueue(right)
            }
        }
    }
}


// MARK: - 二叉树遍历应用
extension BinaryTree {
    
    /// 判断是否为完全二叉树
    func isComplteBinaryTree() -> Bool {
        
        if root == nil { return false }
        
        let queue = SingleQueue<TreeNode<E>>()
        queue.enQueue(root)
        var isLeaf = false // 是否为叶子节点
        
        while !queue.isEmpty() {
            
            var node = queue.deQueue()
            //5、叶子结点 之后的节点都要是叶子结点
            if isLeaf && !(node?.isLeftChild())! {
                return false
            }
            
            
            if node?.left != nil {
                // 1.1、node.left != nil && node.right != nil
                queue.enQueue(node)
            }else if node?.right != nil { // 左子节点入队
                // 2、node.left == nil && node.right != nil
                return false
            }
            
            if node?.right != nil { // 右子节点入队
                // 1.2、node.left != nil && node.right != nil
                queue.enQueue(node)
            }else {
                // 3、node.left == nil && node.right == nil
                // 4、node.left != nil && node.right == nil
                isLeaf = true
            }
        }
        
        return true
    }
    
    /// 计算二叉树的高度 - 迭代实现 （层序遍历）
    func treeHeight() -> Int {
        if root == nil { return 0 }
        
        let queue = SingleQueue<TreeNode<E>>()
        queue.enQueue(root)
        
        
        var height = 0 // 高度
        var leverCount = 1 // 每一层的个数
        
        while !queue.isEmpty() {
            var node = queue.deQueue()
            leverCount -= 1
            
            if node?.left != nil {
                queue.enQueue(node?.left)
            }
            if node?.right != nil {
                queue.enQueue(node?.right)
            }
            
            if leverCount == 0 {
                leverCount = queue.size()
                height += 1
            }
        }
        
        return height
    }
    
    
    /// 计算二叉树的高度 - 遍历实现
    func treeHeight2() -> Int {
        getHeight(node: root)
    }
    
    func getHeight(node: TreeNode<E>?) -> Int {
        
        guard let node else { return 0}
        
        return 1 + max(getHeight(node: node.left), getHeight(node: node.right))
    }
}


// MARK: - 中序遍历 前驱节点和后继节点
extension BinaryTree {
    
    /// 获取当前节点的前序节点
    func prevNode(_ node: TreeNode<E>?) -> TreeNode<E>? {
        
        if node == nil || node?.left == nil {
            return nil
        }
        
        var currNode = node?.left
        while currNode?.right != nil {
            currNode = currNode?.right
        }
        
        return currNode
    }

    /// 获取当前节点的后序节点
    func nextNode(_ node: TreeNode<E>?) -> TreeNode<E>? {
        
        if node == nil || node?.right == nil {
            return nil
        }
        
        var currNode = node?.right
        while currNode?.left != nil {
            currNode = currNode?.left
        }
        
        return currNode
    }
}
 

// MARK: - 打印二叉树
extension BinaryTree: BinaryTreeProtocol {
    
    func getRoot() -> Any? {
        return root as Any
    }
    
    func left(node: Any?) -> Any? {
        if let n = node as? TreeNode<E> {
            return n.left as Any
        }
        return NSObject()
    }
    
    func right(node: Any?) -> Any? {
        if let n = node as? TreeNode<E> {
            return n.right as Any
        }
        return NSObject()
    }
    
    func string(node: Any?) -> String {
        
        if let rbNode = node as? RBNode<E> {
            
            if rbNode.isRed {
                return "R_\(rbNode.element!)"
            }else {
                return "\(rbNode.element!)"
            }
            
        }else if let treeNode = node as? TreeNode<E> {
            return "\(treeNode.element!)"
        }
        
        return "-"
    }
}
