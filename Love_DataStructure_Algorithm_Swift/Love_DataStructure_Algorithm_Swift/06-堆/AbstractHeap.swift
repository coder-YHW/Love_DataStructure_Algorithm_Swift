//
//  AbstractHeap.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/29.
//

import Cocoa


class AbstractHeap<E: Comparable> {
    
    /// 比较
    var comparable: ((E, E) -> Bool)?
    
    
    init(compare: ((E, E) -> Bool)? = nil) {
        self.comparable = compare
    }
    
    
    /// 元素的数量
    func count() -> Int {
        return 0
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return count() == 0
    }
    
    /**清空元素*/
    func clear() { }
    
    /**添加元素*/
    func add(val: E) { }
    
    /**添加元素-数组*/
    func addAll(vals: [E]) { }
    
    /// 获得堆顶元素
    func top() -> E? {
        return nil
    }
    
    /// 删除堆顶元素
    func remove() -> E? {
        return nil
    }
    
    /// 删除堆顶元素的同时插入一个新元素
    func replace(val: E) -> E? {
        return nil
    }
    
    func compare(lhs: E, rhs: E) -> Bool {
        if let com = comparable {
            return com(lhs, rhs)
        }
        return lhs > rhs
    }
}
