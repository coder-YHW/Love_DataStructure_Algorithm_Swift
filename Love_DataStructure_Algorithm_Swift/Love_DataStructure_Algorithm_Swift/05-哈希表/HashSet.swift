//
//  HashSet.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/21.
//

import Cocoa

class HashSet<E: Hashable & Comparable>: Set<E> {

    
    //MARK: - 属性
    fileprivate let map = HashMap<E, E>()
    
    
    //MARK: - override
    /**元素个数*/
    override func size() -> Int {
        return map.count()
    }
    
    /**是否为空*/
    override func isEmpty() -> Bool {
        return map.isEmpty()
    }
    
    /**清除所有元素*/
    override func clear() {
        map.clear()
    }
    
    /// 是否包含某元素
    override func contains(_ val: E) -> Bool {
        return map.containsKey(key: val)
    }
    
    /**添加元素*/
    override func add(val: E) {  // // HashMap会覆盖重复元素
        map.put(key: val, val: nil)
    }
    
    /**删除元素*/
    override func remove(val: E) {
        map.remove(key: val)
    }
    
    /**遍历所有元素**/
    override func traversal(setVisitor: ((E) -> ())? = nil) {
        
        map.traversal { val, _ in
            if let v = val, let setVisitor {
                setVisitor(v)
            }
        }
    }
    
    /// 获取所有元素
    override func allElements() -> [E] {
        var array = [E]()
        map.traversal { val, _ in
            if let v = val {
                array.append(v)
            }
        }
        return array
    }
}
