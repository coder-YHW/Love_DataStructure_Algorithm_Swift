//
//  UnionFindNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/22.
//

import Cocoa

class UnionFindNode<V: Hashable & Comparable>: Comparable {
    
    
    //MARK: - 属性
    var value: V?
    var parent: UnionFindNode<V>?
    var rank = 1
    
    
    //MARK: - 构造函数
    init(val: V?) {
        value = val
        parent = self
    }
    
    
    //MARK: - Comparable
    static func == (lhs: UnionFindNode<V>, rhs: UnionFindNode<V>) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func < (lhs: UnionFindNode<V>, rhs: UnionFindNode<V>) -> Bool {
        let lElement = lhs.value
        let rElement = rhs.value

        if let lhsVal = lElement, let rhsVal = rElement {
            return lhsVal < rhsVal
        } else if lElement != nil && rElement == nil {
            return false
        } else if lElement == nil && rElement != nil {
            return true
        }
        return false
    }
    
}
