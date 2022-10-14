//
//  BinaryBalanceSearchTree.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/29.
//

import Cocoa

/// 二叉平衡搜索树
class AVLTree<E: Comparable>: BBSTree<E> {
    
    //MARK: override
    /// 重写node构造方法
    override func createNode(element: E?, parent: TreeNode<E>?) -> TreeNode<E> {
        return AVLNode(element: element, parent: parent as? AVLNode<E>)
    }
    
    /// 添加node之后的调整节点
    override func afterAdd(_ node: TreeNode<E>) {
        
        var parent = node.parent
        
        while let currentNode = parent { // 0、沿着父节点一直往上 寻找最近的不平衡节点
            
            if isBalanceNode(currentNode as! AVLNode) { // 1、是平衡二叉搜索树
                // 更新节点高度
                updateHeight(currentNode as? AVLNode)
                
            } else { // 2、不是平衡二叉搜索树
                // 需要平衡节点
                recoverBalance(currentNode as! AVLNode)
//                rotateBalance(currentNode as! AVLNode)
                // 最近的不平衡节点恢复平衡 整颗树恢复平衡
                break // 退出while循环
            }
            
            parent = currentNode.parent ?? nil
        }
    }
    
    /// 删除node之后的调整节点
    override func afterRemove(_ node: TreeNode<E>) {
        
        var parent = node.parent
        
        while let currentNode = parent  { // 0、沿着父节点一直往上 寻找最近的不平衡节点
            
            if isBalanceNode(currentNode as! AVLNode) { // 1、是平衡二叉搜索树
                // 更新节点高度
                updateHeight(currentNode as? AVLNode)
            } else { // 2、不是平衡二叉搜索树
                // 需要平衡节点
//                recoverBalance(currentNode as! AVLNode)
                rotateBalance(currentNode as! AVLNode)
                // 恢复平衡之后 - 不能break
            }
           
            parent = currentNode.parent ?? nil
        }
    }
    
    //MARK: 旋转之后更新高度
    /// 旋转后 - 依次更新高度parent、grand —— 先低后高
    override func afterRotate(_ grand: TreeNode<E>, parent: TreeNode<E>, child: TreeNode<E>?) {
        
        super.afterRotate(grand, parent: parent, child: child)
        
        // 依次更新高度parent、grand —— 先低后高
        updateHeight(grand as? AVLNode)
        updateHeight(parent as? AVLNode)
    }
    
    /// 平衡旋转后 - 依次更新b-f-d的高度 —— 先低后高
    override func rotate(r: TreeNode<E>,
                         a: TreeNode<E>?, b: TreeNode<E>?, c: TreeNode<E>?,
                         d: TreeNode<E>,
                         e: TreeNode<E>?, f: TreeNode<E>?, g: TreeNode<E>?) {
         
        super.rotate(r: r, a: a, b: b, c: c, d: d, e: e, f: f, g: g)
        
        // 依次更新b-f-d的高度 —— 先低后高
        if let node = f {
            updateHeight(node as? AVLNode)
        }
        
        if let node = b {
            updateHeight(node as? AVLNode)
        }
        
        updateHeight(d as? AVLNode)
    }
}

extension AVLTree {
    //MARK: 恢复平衡 - 法一 - 旋转之后记得更新高度
    /// 恢复平衡(统一处理)
    fileprivate func rotateBalance(_ grand: AVLNode<E>) {
        
        guard let parent = grand.tallerChild(), let node = parent.tallerChild() else {
            return
        }
        
        if parent.isLeftChild() { // L
            if node.isLeftChild() { // L
                rotate(r: grand, a: node.left, b: node, c: node.right, d: parent, e: parent.right, f: grand, g: grand.right)
            } else { // R
                // LR:先左旋在右旋
                rotate(r: grand, a: parent.left, b: parent, c: node.left, d: node, e: node.right, f: grand, g: grand.right)
            }
        } else { // R
            if node.isLeftChild() { // L
                // RL 先右旋在左旋
                rotate(r: grand, a: grand.left, b: grand, c: node.left, d: node, e: node.right, f: parent, g: parent.right)
            } else { // R
                // RR: 左旋
                rotate(r: grand, a: grand.left, b: grand, c: parent.left, d: parent, e: node.left, f: node, g: node.right)
            }
        }
    }
    
    //MARK: 恢复平衡 - 法二 - 旋转之后记得更新高度
    /// 恢复平衡(左右旋转单独处理)
    fileprivate func recoverBalance(_ grand: AVLNode<E>) {
        
        guard let parent = grand.tallerChild(), let node = parent.tallerChild() else {
            return
        }
        
        if parent.isLeftChild() { // L
            if node.isLeftChild() { // LL
                rotateRight(grand)
            } else { // LR
                // LR: 先左旋在右旋
                rotateLeft(parent)
                rotateRight(grand)
            }
        } else { // R
            if node.isLeftChild() { // L
                // RL 先右旋在左旋
                rotateRight(parent)
                rotateLeft(grand)
            } else { // R
                // RR: 左旋
                rotateLeft(grand)
            }
        }
    }

    /// 当前节点是否是平衡的
    fileprivate func isBalanceNode(_ node: AVLNode<E>) -> Bool {
        return abs(node.balanceFactor()) <= 1
    }
    
    /// 更新高度
    fileprivate func updateHeight(_ node: AVLNode<E>?) {
        node?.updateBalanceFactor()
    }
}

