//
//  TreeSet.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/11.
//

import Cocoa

class TreeSet<E: Hashable & Comparable>: Set<E> {

    
    //MARK: - 属性
    fileprivate var tree = RBTree<E>()
    
    
    //MARK: - override
    /**元素个数**/
    override func size() -> Int {
        return tree.count
    }
    
    /**是否为空**/
    override func isEmpty() -> Bool {
        return tree.isEmpty()
    }
    
    /**清除所有元素**/
    override func clear() {
        tree.clear()
    }
    
    /**是否包含某元素**/
    override func contains(_ val: E) -> Bool {
        return tree.contains(val)
    }
    
    /**添加元素**/
    override func add(val: E) {  // BSTree会覆盖重复元素
        tree.add(val)
    }
    
    /**删除元素**/
    override func remove(val: E) {
        tree.remove(val)
    }
    
    /**遍历所有元素**/
    override func traversal(setVisitor: ((E) -> ())? = nil) {
        
        tree.levelOrder { element in
            
            if let setVisitor, let element {
                setVisitor(element)
            }
        }
    }
    
    /**获取所有元素**/
    override func allElements() -> [E] {
        
        var array = [E]()
        
        tree.levelOrder { element in
    
            if let element {
                array.append(element)
            }
        }
        
        return array
    }
}
