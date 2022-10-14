//
//  BSTree.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/19.
//

import Cocoa

/// 二叉搜索树
class BSTree<E: Comparable> : BinaryTree<E> {

    //MARK: - 方法
    /// 节点是否存在
    func contains(_ element: E) -> Bool {
        return getNodeFromElement(element) != nil
    }
    
    /// 查找对应node
    func getNodeFromElement(_ element: E) -> TreeNode<E>? {
        
        var node = root
        var cmp = 0

        while node != nil {
            
            if let element2 = node?.element {
                
                cmp = compare(element1: element, element2: element2)
    
                if cmp > 0 { // cmp > 0 右子树
                    node = node?.right
                }else if cmp < 0 { // cmp < 0 左子树
                    node = node?.left
                }else { // cmp == 0 就是这个节点
                    return node
                }
                
            }else {
                print("node?.element为nil")
                return nil
            }
        }

        return node
    }
    
    
    
    //MARK: - 添加删除
    /// 添加节点
    func add(_ element: E?) {
        // 0、可选类型非nil判断
        guard let element = element else { return }
        
        // 1、添加第一个节点- 根节点
        if root == nil {
            root = createNode(element: element, parent: nil)
            count += 1
            
            // 添加节点后平衡二叉搜索树 - 子类实现
            afterAdd(root!)
        
            return
        }
        
        // 2、添加的不是第一个节点 - 找到父节点
        var node = root
        var parent = root
        var cmp = 0
        
        while node != nil {
            cmp = compare(element1: element, element2: node!.element!)
            parent = node // 更新父节点
            
            if cmp > 0 { // cmp > 0 右子树
                node = node?.right
            }else if cmp < 0 { // cmp < 0 左子树
                node = node?.left
            }else { // cmp == 0 覆盖
                node?.element = element
                return
            }
        }
        
        // 3、根据找到的父节点-插入新节点
        let newNode = createNode(element: element, parent: parent)
        if cmp > 0 {
            parent?.right = newNode
        }else {
            parent?.left = newNode
        }
        
        // 索引+= 1
        count += 1
        
        // 添加节点后平衡二叉搜索树 - 子类实现
        afterAdd(newNode)
    }
    
    /// 删除节点
    func remove(_ element: E) {
        remove(getNodeFromElement(element))
    }
    
    /// 删除对应的node
    fileprivate func remove(_ node: TreeNode<E>?) {
        // 0、可选类型非nil判断
        guard var node else { return }
        
        // 1、node的度为2 - 它的前驱节点或后继节点 只能是度为0或1的节点
        if node.hasTwoChildren() {
            // 1.1、找到后继节点 - 肯定是存在的
            let nextNode = nextNode(node)
            // 1.2、用后继节点的值覆盖度为2的节点
            node.element = nextNode?.element
            // 1.3、删除后继节点 - 用后继节点覆盖node 后续再删除node
            node = nextNode!
        }
        
        // 删除node节点（后面node的度必然是0或1）
        let replcaeNode = node.left != nil ? node.left : node.right
        
        if let replcaeNode { // 2、node的度为1 (更改子节点的parent➕更改父节点的左子树或右子树为replcaeNode)
            
            replcaeNode.parent = node.parent
            
            if node.parent == nil {
                root = replcaeNode
            }else if node.isLeftChild() {
                node.parent?.left = replcaeNode
            }else if node.isRightChild() {
                node.parent?.right = replcaeNode
            }
            
            // 索引-=1
            count -= 1
            
            // 删除节点后平衡二叉搜索树 - 子类实现
            afterRemove(replcaeNode)
            
        }else { // 3、node的度为0 （更改父节点的左子树或右子树为replcaeNode == nil）
            
            if node.parent == nil {
                root = nil
            }else if node.isLeftChild() {
                node.parent?.left = nil
            }else if node.isRightChild() {
                node.parent?.right = nil
            }
            
            // 索引-=1
            count -= 1
            
            // 删除节点后平衡二叉搜索树 - 子类实现
            afterRemove(node)
        }
    }
    
    
    //MARK: 平衡二叉搜索树 - 子类实现
    // (extension里定义的方法默认不能被子类重写)
    /// 重写node构造方法
    public func createNode(element: E?, parent: TreeNode<E>?) -> TreeNode<E> {
        return TreeNode(element: element, parent: parent)
    }
    
    /// 添加node之后的调整节点
    public func afterAdd(_ node: TreeNode<E>) {
//        print("需要被子类重写")
    }

    /// 删除node之后的调整节点
    public func afterRemove(_ node: TreeNode<E>) {
//        print("需要被子类重写")
    }
}


//MARK: - 比较器
extension BSTree {
    
    fileprivate func compare(element1: E, element2: E) -> Int {
        
        if element1 > element2 {
            return 1
        }else if element1 < element2 {
            return -1
        }else {
            return 0
        }
    }
}


//MARK: 遍历
extension BSTree {
    /// 前序遍历(递归)
    func preorderForRecursion() -> [E] {
        return preorderEach(root)
    }
    
    /// 前序遍历(迭代)
    func preorderForEach() -> [E] {
        if root == nil { return [] }
        var node = root
        var array = [E]()
        
        let stack = Statck<TreeNode<E>>()
        stack.push(node)
        
        while !stack.isEmpty() {
            node = stack.pop()
            if let tmp = node?.element {
                array.append(tmp)
            }
            
            if let right = node?.right {
                stack.push(right)
            }
            if let left = node?.left {
                stack.push(left)
            }
        }
        
        return array
    }
    
    /// 中序遍历(递归)
    func infixOrderForRecursion() -> [E] {
        return infixOrderEach(root)
    }
    
    /// 中序遍历(迭代)
    func infixOrderForEach() -> [E] {
        if root == nil { return [] }
        var node = root
        var array = [E]()
        
        let stack = Statck<TreeNode<E>>()
        while !stack.isEmpty() || node != nil {
            while node != nil {
                stack.push(node)
                node = node?.left
            }
            
            let peek = stack.pop()
            if let element = peek?.element {
                array.append(element)
            }
            node = peek?.right
        }
        
        return array
    }
    
    /// 后序遍历(递归)
    func epilogueForRecursion() -> [E] {
        return epilogueEach(root)
    }
    
    /// 后序遍历(迭代)
    func epilogueForEach() -> [E] {
        if root == nil { return [] }
        var node = root
        var array = [E]()
        var tmpNode: TreeNode<E>?
        
        let stack = Statck<TreeNode<E>>()
        stack.push(node)
        
        while !stack.isEmpty() {
            let peek = stack.peek()
            let isLeaf = peek?.isLeaf() ?? false
            
            // 栈顶节点是否是椰子节点, 上一次访问节点是否是栈顶节点的子节点
            if isLeaf || tmpNode?.parent == peek {
                node = stack.pop()
                tmpNode = node
                if let tmp = node?.element {
                    array.append(tmp)
                }
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
        
        return array
    }
    
    /// 层序遍历
    func levelOrderForEach() -> [E] {
        var node = root
        if node == nil { return [] }
        var array = [E]()
        
        let queueLink = SingleQueue<TreeNode<E>>()
        queueLink.enQueue(node)
        while !queueLink.isEmpty() {
            node = queueLink.deQueue()
            if let element = node?.element {
                array.append(element)
            }
            if let left = node?.left {
                queueLink.enQueue(left)
            }
            if let right = node?.right {
                queueLink.enQueue(right)
            }
        }
        
        return array
    }
    
    /// 前序遍历
    fileprivate func preorderEach(_ node: TreeNode<E>?) -> [E] {
        if node == nil { return [] }
        var array = [E]()
        
        if let item = node?.element  {
            array.append(item)
        }
        
        let leftArr = preorderEach(node?.left)
        leftArr.forEach({ array.append($0) })
        
        let rightArr = preorderEach(node?.right)
        rightArr.forEach({ array.append($0) })
        
        return array
    }
    
    /// 中序遍历
    fileprivate func infixOrderEach(_ node: TreeNode<E>?) -> [E] {
        if node == nil { return [] }
        var array = [E]()
        
        let leftArr = infixOrderEach(node?.left)
        leftArr.forEach({ array.append($0) })
        
        if let item = node?.element  {
            array.append(item)
        }
        
        let rightArr = infixOrderEach(node?.right)
        rightArr.forEach({ array.append($0) })
        
        return array
    }
    
    /// 后序遍历
    fileprivate func epilogueEach(_ node: TreeNode<E>?) -> [E] {
        if node == nil { return [] }
        var array = [E]()
        
        let leftArr = epilogueEach(node?.left)
        leftArr.forEach({ array.append($0) })
        
        let rightArr = epilogueEach(node?.right)
        rightArr.forEach({ array.append($0) })
        
        if let item = node?.element {
            array.append(item)
        }
        
        return array
    }
}


//MARK: 部分力扣题目
extension BSTree {
    /// 107. 二叉树的层序遍历 II : https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/
    /// 给定一个二叉树，返回其节点值自底向上的层序遍历。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）
//    func levelOrderBottom() -> [[E]] {
//        if root == nil { return [] }
//
//        var leverCount = 1
//        var elementArr = [E]()
//        var node = root
//        let stack = Statck<[E]>()
//
//        let queueLink = SingleQueue<Node<E>>()
//        queueLink.enQueue(root)
//
//        while !queueLink.isEmpty() {
//            leverCount -= 1
//
//            node = queueLink.deQueue()
//            if let element = node?.element {
//                elementArr.append(element)
//            }
//
//            if node?.left != nil {
//                queueLink.enQueue(node?.left)
//            }
//            if node?.right != nil {
//                queueLink.enQueue(node?.right)
//            }
//
//            if leverCount == 0 {
//                stack.push(elementArr)
//                leverCount = queueLink.size()
//                elementArr.removeAll()
//            }
//        }
//
//        var array = [[E]]()
//        for _ in 0..<stack.size() {
//            if let element = stack.pop() {
//                array.append(element)
//            }
//        }
//        return array
//    }
    
    
    /// 二叉树的宽度: https://leetcode-cn.com/problems/maximum-width-of-binary-tree
    /// 给定一个二叉树，编写一个函数来获取这个树的最大宽度。树的宽度是所有层中的最大宽度。这个二叉树与满二叉树（full binary tree）结构相同，但一些节点为空。
    /// 每一层的宽度被定义为两个端点（该层最左和最右的非空节点，两端点间的null节点也计入长度）之间的长度。
    func widthOfBinaryTree() -> Int {
        if root == nil { return 0 }
        
        var node = root
        var widthArr = [Int]()
        var leverCount = 1
        
        let queueLink = SingleQueue<TreeNode<E>>()
        queueLink.enQueue(node)
        
        while !queueLink.isEmpty() {
            node = queueLink.deQueue()
            leverCount -= 1
            
            if node?.left != nil {
                queueLink.enQueue(node?.left)
            }
            if node?.right != nil {
                queueLink.enQueue(node?.right)
            }
            
            if leverCount == 0 {
                leverCount = queueLink.size()
                widthArr.append(leverCount)
            }
        }
        
        return widthArr.max() ?? 0
    }
    
    /// 给定一个二叉树，判断其是否是一个有效的二叉搜索树。
    /// 假设一个二叉搜索树具有如下特征：
    ///  - 节点的左子树只包含小于当前节点的数。
    ///  - 节点的右子树只包含大于当前节点的数。
    ///  - 所有左子树和右子树自身必须也是二叉搜索树。
    ///  - https://leetcode-cn.com/problems/validate-binary-search-tree
    func isValidBST() -> Bool {
        if root == nil { return true }
        
        var node = root
        var stackList = [TreeNode<E>?]()
        stackList.append(node)
        
        while !stackList.isEmpty {
            node = stackList.removeFirst()
            let nodeValue = node?.element
            
            if let left = node?.left {
                if left.element! > nodeValue! {
                    return false
                }
                stackList.append(left)
            }
            if let right = node?.right {
                if right.element! < nodeValue! {
                    return false
                }
                stackList.append(right)
            }
        }
        
        return true
    }
    
    /// 根据一棵树的前序遍历与中序遍历构造二叉树(迭代)
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode<Int>? {
        if preorder.count != inorder.count { return nil }
        if preorder.count == 0 { return nil }
        
        let root = TreeNode(element: preorder[0])
        var stackList = [TreeNode<Int>]()
        stackList.append(root)
        
        var inorderIndex = 0
        for i in 1..<preorder.count {
            let preorderVal = preorder[i]
            var node = stackList.last
            
            if node!.element != inorder[inorderIndex] {
                let left = TreeNode(element: preorderVal)
                node?.left = left
                stackList.append(left)
            } else {
                while !stackList.isEmpty && stackList.last!.element == inorder[inorderIndex] {
                    node = stackList.removeLast()
                    inorderIndex += 1
                }
                let right = TreeNode(element: preorderVal)
                node?.right = right
                stackList.append(right)
            }
        }
        
        
        return root
    }
    
    /// 根据一棵树的前序遍历与中序遍历构造二叉树(递归)
    func buildTreeNode(_ preorder: [Int], _ inorder: [Int]) -> TreeNode<Int>? {
        if preorder.count != inorder.count { return nil }
        if preorder.count == 0 { return nil }
        if preorder.count == 1 {
            return TreeNode(element: preorder[0])
        }
        
        var root: TreeNode<Int>?
        let firstVal = preorder[0]
        root = TreeNode(element: firstVal)
        
        let subArr = inorder.split(separator: firstVal)
        var leftInorder = [Int]()
        var rightInorder = [Int]()
        if subArr.count > 1 {
            leftInorder = Array(subArr[0])
            rightInorder = Array(subArr[1])
        } else if subArr.count == 1 {
            let oneArr = Array(subArr[0])
            if oneArr.count > 0 {
                if oneArr[0] > firstVal {
                    rightInorder = oneArr
                } else {
                    leftInorder = oneArr
                }
            }
        }
        
        let leftPreorder = preorder.filter({ leftInorder.contains($0) })
        root?.left = buildTree(leftPreorder, leftInorder)
        
        let rightPreorder = preorder.filter({ rightInorder.contains($0) })
        root?.right = buildTree(rightPreorder, rightInorder)
        
        return root
    }
    
    /// 根据一棵树的后序遍历与中序遍历构造二叉树(迭代)
    func buildTreeBind(_ inorder: [Int], _ postorder: [Int]) -> TreeNode<Int>? {
        if postorder.count != inorder.count { return nil }
        if postorder.count == 0 { return nil }
        
        let root = TreeNode(element: postorder[postorder.count - 1])
        var stackList = [TreeNode<Int>]()
        stackList.append(root)
        
        var preorder = [Int]()
        var inordere = [Int]()
        postorder.reversed().forEach({ preorder.append($0) })
        inorder.reversed().forEach({ inordere.append($0) })
        
        var inorderIndex = 0
        for i in 1..<preorder.count {
            let preorderVal = preorder[i]
            var node = stackList.last

            if node!.element != inordere[inorderIndex] {
                let right = TreeNode(element: preorderVal)
                node?.right = right
                stackList.append(right)
            } else {
                while !stackList.isEmpty && stackList.last!.element == inordere[inorderIndex] {
                    node = stackList.removeLast()
                    inorderIndex += 1
                }
                let left = TreeNode(element: preorderVal)
                node?.left = left
                stackList.append(left)
            }
        }
        
        return root
    }
    
    /// 最近公共祖先
    func lowestCommonAncestor(lhs: E, rhs: E) -> E? {
        let lhsNode = getNodeFromElement(lhs)
        let rhsNode = getNodeFromElement(rhs)
        if lhsNode == nil || rhsNode == nil { return nil }
        
        var first = lhsNode
        var last = rhsNode
        while first != nil {
            while last != nil {
                if first?.element == last?.element {
                    return first?.element
                }
                last = last?.parent
            }
            last = rhsNode
            first = first?.parent
        }
        
        return nil
    }
}
