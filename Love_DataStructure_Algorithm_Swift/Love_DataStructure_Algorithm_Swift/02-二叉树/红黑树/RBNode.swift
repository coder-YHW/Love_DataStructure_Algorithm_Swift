//
//  RBNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/29.
//

import Cocoa


class RBNode<E: Comparable>: TreeNode<E> {

    //MARK: - 属性
    public var isRed = true

//    public var children: [RBNode]

    
    //MARK: - 构造函数
    init(element: E?, parent: RBNode? = nil) {
        super.init(element: element, parent: parent)
        self.isRed = true
    }
    

    
    
//    static func < (lhs: RBNode, rhs: RBNode) -> Bool {
//        let lElement = lhs.val
//        let rElement = rhs.val
//        return lElement < rElement
//    }
//
//    static func == (lhs: RBNode, rhs: RBNode) -> Bool {
//        return lhs.val == rhs.val
//    }
}


