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
    
    // MARK: 前序遍历(递归)
    /// 前序遍历(递归) - （root->左子树->右子树）
    public func preOrderCircle(treeVisitor: ((E?) -> ())?) {
        preOrderCircle(node: root, treeVisitor: treeVisitor)
    }
    
    fileprivate func preOrderCircle(node: TreeNode<E>?, treeVisitor: ((E?) -> ())? = nil) {
        
        if let node {
//            print(node)
            if let treeVisitor {
                treeVisitor(node.element)
            }else {
                print(node)
            }
            
            preOrderCircle(node: node.left, treeVisitor: treeVisitor)
            preOrderCircle(node: node.right, treeVisitor: treeVisitor)
        }
    }
    
    // MARK: 中序遍历(递归)
    /// 中序遍历(递归) - （左子树->root->右子树）
    public func inOrderCircle(treeVisitor: ((E?) -> ())?) {
        inOrderCircle(node: root, treeVisitor: treeVisitor)
    }
    
    fileprivate func inOrderCircle(node: TreeNode<E>?, treeVisitor: ((E?) -> ())? = nil) {
        
        if let node {
            inOrderCircle(node: node.left, treeVisitor: treeVisitor)
            
//            print(node)
            if let treeVisitor {
                treeVisitor(node.element)
            }else {
                print(node)
            }
            
            inOrderCircle(node: node.right, treeVisitor: treeVisitor)
        }
    }
    
    // MARK: 后序遍历(递归)
    /// 后序遍历(递归) - （左子树->右子树->root）
    public func postOrderCircle(treeVisitor: ((E?) -> ())?) {
        postOrderCircle(node: root, treeVisitor: treeVisitor)
    }
    
    fileprivate func postOrderCircle(node: TreeNode<E>?, treeVisitor: ((E?) -> ())? = nil) {
        
        if let node {
            postOrderCircle(node: node.left, treeVisitor: treeVisitor)
            postOrderCircle(node: node.right, treeVisitor: treeVisitor)
            
//            print(node)
            if let treeVisitor {
                treeVisitor(node.element)
            }else {
                print(node)
            }
        }
    }
    
    // MARK: - 层序遍历(迭代)
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
            }
            
            if let left = node.left { // 1、左子节点入队
                queue.enQueue(left)
            }
            
            if let right = node.right { // 2、右子节点入队
                queue.enQueue(right)
            }
        }
    }
    
    // MARK: 前序遍历(迭代) - 层序遍历queue换成stack 右子树先入栈
    /// 前序遍历(迭代) - 层序遍历队列queue换成栈stack
    public func preOrder(treeVisitor: ((E?) -> ())?) {
        
        if root == nil {
            return
        }
        
        let stack = Statck<TreeNode<E>>()
        stack.push(root)

        while !stack.isEmpty() {
            
            guard let node = stack.pop() else {
                break
            }
//            print(node!)
            if let treeVisitor {
                treeVisitor(node.element)
            }

            if let right = node.right { // 右子树先入栈
                stack.push(right)
            }
            
            if let left = node.left {  // 左子树再入栈
                stack.push(left)
            }
        }
    }

    // MARK: 中序遍历(迭代) - 层序遍历queue换成stack
    /// 中序遍历(迭代)
    public func inOrder(treeVisitor: ((E?) -> ())?) {
        
        if root == nil {
            return
        }
        
        // 0、创建栈
        var node = root
        let stack = Statck<TreeNode<E>>()
        
        while !stack.isEmpty() || node != nil { // 注意：或
            // 1、一路往左走 直到最左位置 路上遇到的节点都入栈 （包括根节点）
            while node != nil {
                stack.push(node)
                node = node?.left
            }

            // 2、不能再往左走了 弹出栈顶元素 赋值给node访问
            guard let currNode = stack.pop() else {
                break
            }
                
//            print(currNode)
            if let treeVisitor {
                treeVisitor(currNode.element)
            }
            
            // 3、查看一下currNode的右子树 如果右子树为nil 结束本次循环
            node = currNode.right
        }
    }

    // MARK: 后序遍历(迭代) - 层序遍历queue换成stack
    /// 后序遍历(迭代)
    public func postOrder(treeVisitor: ((E?) -> ())?) {
        
        if root == nil {
            return
        }
        
        // 1、将根节点入栈
        let stack = Statck<TreeNode<E>>()
        stack.push(root)
        var currNode: TreeNode<E>? // 用来记录上一次弹出栈的节点 （子节点已出栈 轮到父节点）

        while !stack.isEmpty() {
            // 2、查看栈顶是否是叶子结点
            guard let peek = stack.peek() else {
                break
            }

            // 2.1、栈顶节点是否是椰子节点 或 上一次访问节点是否是栈顶节点的子节点 出栈 （子节点已出栈 轮到父节点）
            if peek.isLeaf() || currNode?.parent == peek {
                // 3、出栈
                currNode = stack.pop()
//                print(currNode!)
                if let treeVisitor {
                    treeVisitor(currNode!.element)
                }
                
            } else { // 2.2、栈顶不是叶子结点 右子树先入栈 左子节再入栈
   
                if let right = peek.right {  // 右子树先入栈
                    stack.push(right)
                }
                if let left = peek.left { // 左子节再入栈
                    stack.push(left)
                }
            }
        }
    }
    
    // MARK: - 前序遍历(Morris)
    /// 前序遍历(Morris)
    public func preOrderMorris(treeVisitor: ((E?) -> ())?) {
        
        if root == nil {
            return
        }
        
        var curr : TreeNode<E>? = root // 记录当前遍历的节点
        var mostRight : TreeNode<E>? = nil  // 记录当前节点的前驱节点
        
        while curr != nil {
            // mostRight移动到curr的左子节点
            mostRight = curr?.left
            
            if mostRight != nil { // 左子节点不为空
                // 左子节点不为空 一直向右搜索直到空，即curr的前驱节点
                // 或者 回到原始位置结束 （此时mostRight已经到最左边）
                while mostRight?.right != nil && mostRight?.right != curr {
                    mostRight = mostRight?.right
                }
                // 如果沿着mostRight一直找到了空，表示为第一次遍历到
                // 那么连接到开始遍历的地方，且mostRight继续向左走，去连接下面的节点
                if mostRight?.right == nil {
                    
//                    print(curr!)
                    if let treeVisitor {
                        treeVisitor(curr!.element)
                    }
                    
                    // 如果最右节点还没有跟当前节点建立关系，就建立关系。 （画了一条线 把mostRight连接到curr）
                    mostRight?.right = curr
                    // curr继续往左走
                    curr = curr?.left
    
                }else { // mostRight?.right == curr
                    
                    // 如果最右节点已经跟当前节点建立过关系，本次是第二次遍历到curr节点，则把关系清楚。
                    mostRight?.right = nil
                    
                    // 回溯 - curr回到之前的位置
                    curr = curr?.right
                }
            }else { // 左子节点mostRight为空 curr已经走到最左边，无法继续往左走了。
//                print(curr!)
                if let treeVisitor {
                    treeVisitor(curr!.element)
                }
                
                // 回溯 - curr回到之前的位置
                curr = curr?.right
            }

        }
    }
    
    // MARK: 中序遍历(Morris)
    /// 后序遍历(Morris)
    public func inOrderMorris(treeVisitor: ((E?) -> ())?) {
        
        if root == nil {
            return
        }
        
        var curr : TreeNode<E>? = root // 记录当前遍历的节点
        var mostRight : TreeNode<E>? = nil  // 记录当前节点的前驱节点
        
        while curr != nil {
            // mostRight移动到curr的左子节点
            mostRight = curr?.left
            
            if mostRight != nil { // 左子节点不为空
                // 左子节点不为空 一直向右搜索直到空，即curr的前驱节点
                // 或者 回到原始位置结束 （此时mostRight已经到最左边）
                while mostRight?.right != nil && mostRight?.right != curr {
                    mostRight = mostRight?.right
                }
                // 如果沿着mostRight一直找到了空，表示为第一次遍历到
                // 那么连接到开始遍历的地方，且mostRight继续向左走，去连接下面的节点
                if mostRight?.right == nil {
                    
                    // 如果最右节点还没有跟当前节点建立关系，就建立关系。 （画了一条线 把mostRight连接到curr）
                    mostRight?.right = curr
                    // curr继续往左走
                    curr = curr?.left

                }else { // mostRight?.right == curr
                    
                    // 如果最右节点已经跟当前节点建立过关系，本次是第二次遍历到curr节点，则把关系清楚。
                    mostRight?.right = nil
                    
//                    print(curr!)
                    if let treeVisitor {
                        treeVisitor(curr!.element)
                    }
                    
                    // 回溯 - curr回到之前的位置
                    curr = curr?.right
                }
                
            }else { // 左子节点mostRight为空 curr已经走到最左边，无法继续往左走了。
//                print(curr!)
                if let treeVisitor {
                    treeVisitor(curr!.element)
                }
                
                // 回溯 - curr回到之前的位置
                curr = curr?.right
            }
        }
    }
    
    // MARK: 后序遍历(Morris)
    /// 后序遍历(Morris)
    public func postOrderMorris(treeVisitor: ((E?) -> ())?) {
        
        if root == nil {
            return
        }
        
        var curr : TreeNode<E>? = root // 记录当前遍历的节点
        var mostRight : TreeNode<E>? = nil  // 记录当前节点的前驱节点
        
        while curr != nil {
            // mostRight移动到curr的左子节点
            mostRight = curr?.left
            
            if mostRight != nil { // 左子节点不为空
                // 左子节点不为空 一直向右搜索直到空，即curr的前驱节点
                // 或者 回到原始位置结束 （此时mostRight已经到最左边）
                while mostRight?.right != nil && mostRight?.right != curr {
                    mostRight = mostRight?.right
                }
                // 如果沿着mostRight一直找到了空，表示为第一次遍历到
                // 那么连接到开始遍历的地方，且mostRight继续向左走，去连接下面的节点
                if mostRight?.right == nil {
                    
                    // 如果最右节点还没有跟当前节点建立关系，就建立关系。 （画了一条线 把mostRight连接到curr）
                    mostRight?.right = curr
                    // curr继续往左走
                    curr = curr?.left
                    // continue
                    continue
                }else { // mostRight?.right == curr
                    // 如果最右节点已经跟当前节点建立过关系，本次是第二次遍历到curr节点，则把关系清楚。
                    mostRight?.right = nil
                }
            }else { // 左子节点mostRight为空 curr已经走到最左边，无法继续往左走了。
                
                // 回溯 - curr回到之前的位置
                curr = curr?.right
            }
        }
    }
}

// MARK: - 翻转二叉树
extension BinaryTree {
    
    /// 前序遍历(迭代) - （root->左子树->右子树）
    public func preOrderInvertTree() {
        
        if root == nil {
            return
        }
        
        let stack = Statck<TreeNode<E>>()
        stack.push(root)

        while !stack.isEmpty() {
            
            let node = stack.pop()
//            print(node!)
            let temNode = node?.left
            node?.left = node?.right
            node?.right = temNode

            if let right = node?.right { // 1、右子节点先入栈
                stack.push(right)
            }
            
            if let left = node?.left { // 2、左子节点先入栈
                stack.push(left)
            }
        }
    }
    
    /// 中序遍历(迭代) - （左子树->root->右子树）
    public func inOrderInvertTree() {
        
        if root == nil {
            return
        }
        
        // 0、创建栈
        var node = root
        let stack = Statck<TreeNode<E>>()
        
        while !stack.isEmpty() || node != nil { // 注意：或
            // 1、一路往左走 直到最左位置 路上遇到的节点都入栈 （包括根节点）
            while node != nil {
                stack.push(node)
                node = node?.left
            }

            // 2、不能再往左走了 弹出栈顶元素 赋值给node访问
            guard let currNode = stack.pop() else {
                break
            }
//            print(currNode)
            let temNode = currNode.left
            currNode.left = currNode.right
            currNode.right = temNode
            
            // 3、查看一下currNode的右子树 如果右子树为nil 结束本次循环
            node = currNode.right
        }
    }
    
    /// 后序遍历(迭代) - （左子树->右子树->root）
    public func postOrderInvertTree() {
        
        if root == nil {
            return
        }
        
        // 1、将根节点入栈
        let stack = Statck<TreeNode<E>>()
        stack.push(root)
        var currNode: TreeNode<E>? // 用来记录上一次弹出栈的节点 （子节点已出栈 轮到父节点）

        while !stack.isEmpty() {
            // 2、查看栈顶是否是叶子结点
            guard let peek = stack.peek() else {
                break
            }

            // 2.1、栈顶节点是否是椰子节点 或 上一次访问节点是否是栈顶节点的子节点 出栈 （子节点已出栈 轮到父节点）
            if peek.isLeaf() || currNode?.parent == peek {
                // 3、出栈
                currNode = stack.pop()
//                print(currNode!)
                let temNode = currNode?.left
                currNode?.left = currNode?.right
                currNode?.right = temNode
                
            } else { // 2.2、栈顶不是叶子结点 右子树先入栈 左子节再入栈
   
                if let right = peek.right {  // 右子树先入栈
                    stack.push(right)
                }
                if let left = peek.left { // 左子节再入栈
                    stack.push(left)
                }
            }
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
//            print(node!)
            let temNode = node?.left
            node?.left = node?.right
            node?.right = temNode
            
            if let left = node?.left {  // 1、左子节点入队
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
