//
//  RBNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/29.
//

import Cocoa

/// 红黑树节点
class RBNode<E: Comparable>: TreeNode<E> {

    //MARK: - 属性
    public var isRed = true

    
    //MARK: - 构造函数
    init(element: E?, parent: RBNode? = nil) {
        super.init(element: element, parent: parent)
        self.isRed = true // 新添加的节点默认为红色节点，这样能让红黑树性质尽快满足
    }
    
}


