//
//  AVLNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/14.
//

import Cocoa

class AVLNode<E: Comparable>: TreeNode<E> {

    //MARK: - 属性
    public var height = 1
    
    
    //MARK: - 构造函数
    init(element: E?, parent: AVLNode? = nil) {
        super.init(element: element, parent: parent)
        self.height = 1
    }
    

}

extension AVLNode {
    
    //MARK: - 方法
    /// 平衡因子
    public func balanceFactor() -> Int {
        
        let leftHeight = left == nil ? 0 : (left! as? AVLNode<E>)?.height ?? 0
        let rightHeight = right == nil ? 0 : (right! as? AVLNode<E>)?.height ?? 0
        return leftHeight - rightHeight
    }
    
    /// 更新平衡因子
    public func updateBalanceFactor() {
        let leftHeight = left == nil ? 0 : (left! as? AVLNode<E>)?.height ?? 0
        let rightHeight = right == nil ? 0 : (right! as? AVLNode<E>)?.height ?? 0
        height = max(leftHeight, rightHeight) + 1
    }
    
    /// 获取高度大的节点
    public func tallerChild() -> AVLNode? {
        
        let leftHeight = left == nil ? 0 : (left! as? AVLNode<E>)?.height ?? 0
        let rightHeight = right == nil ? 0 : (right! as? AVLNode<E>)?.height ?? 0
        
        if leftHeight > rightHeight { // 1、左子树高
            return left as? AVLNode<E>
        }else if rightHeight > leftHeight { // 2、右子树高
            return right as? AVLNode<E>
        }
        
        if isLeftChild() { // 3、左子树 == 右子树
            return left as? AVLNode<E>
        }else {
            return right as? AVLNode<E>
        }
    }
}
