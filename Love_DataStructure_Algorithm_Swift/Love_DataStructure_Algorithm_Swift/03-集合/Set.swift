//
//  Set.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/11.
//

import Cocoa

// 注意闭包的写法: 1、any小写 2、协议不要: 3、多个协议用&隔开
typealias SetVisitor = ((any Comparable & Hashable) -> ())


/// 集合 - 接口设计
class Set<E: Comparable & Hashable> {

    //MARK: - 接口设计
    /**元素个数**/
    func size() -> Int {
        return 0
    }
    
    /**是否为空**/
    func isEmpty() -> Bool {
        return size() == 0
    }
    
    /**清除所有元素**/
    func clear() {}
    
    /**是否包含某元素**/
    func contains(_ val: E) -> Bool {
        return true
    }
    
    /**添加元素**/
    func add(val: E) {}
    
    /**删除元素**/
    func remove(val: E) {}
    
    /**遍历所有元素**/
    func traversal(setVisitor: ((E) -> ())? = nil) {
        
    }
    
    /**获取所有元素**/
    func allElements() -> [E] {
        return []
    }
}
