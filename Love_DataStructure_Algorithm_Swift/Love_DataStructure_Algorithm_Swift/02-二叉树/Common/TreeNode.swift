//
//  TreeNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/19.
//

import Cocoa

/// 二叉树节点
class TreeNode<E: Comparable>: Comparable {
    
    //MARK: - 属性
    var element: E?
    var left: TreeNode?
    var right: TreeNode?
    var parent: TreeNode?
    
    
    //MARK: - 构造函数
    init(element: E?, parent: TreeNode? = nil) {
        self.element = element
        self.parent = parent
    }
    
    
    //MARK: - 方法
    /// 是否是叶子节点
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
    
    /// 有两个节点
    func hasTwoChildren() -> Bool {
        return left != nil && right != nil
    }
    
    /** 是否有左个子树 */
    func hasLeftChild() -> Bool {
        return left != nil
    }

    /** 是否有右子树 */
    func hasRightChild() -> Bool {
        return right != nil
    }

    /** 是否是parent的左子树 */
    func isLeftChild() -> Bool {
        return parent != nil && self == parent?.left
    }

    /** 是否是parent的右子树 */
    func isRightChild() -> Bool {
        return parent != nil && self == parent?.right
    }

    /** 返回兄弟节点 */
    func sibling() -> TreeNode? {
        
        if isLeftChild() {
            return parent?.right
        }
        
        if isRightChild() {
            return parent?.left
        }
        
        return nil
    }
    
    
    //MARK: - Comparable
    static func < (lhs: TreeNode<E>, rhs: TreeNode<E>) -> Bool {
        let lElement = lhs.element
        let rElement = rhs.element
        if lElement == nil && rElement == nil {
            return true
        } else if lElement == nil || rElement == nil {
            return false
        }
        return lElement! < rElement!
    }
    
    static func > (lhs: TreeNode<E>, rhs: TreeNode<E>) -> Bool {
        let lElement = lhs.element
        let rElement = rhs.element
        if lElement == nil && rElement == nil {
            return true
        } else if lElement == nil || rElement == nil {
            return false
        }
        return lElement! > rElement!
    }
    
    static func == (lhs: TreeNode<E>, rhs: TreeNode<E>) -> Bool {
        return lhs.element == rhs.element
    }
    
}




// MARK: - 打印
extension TreeNode : CustomStringConvertible {
    
    var description: String {
        
        return "\(String(describing: element))"
    }
}
