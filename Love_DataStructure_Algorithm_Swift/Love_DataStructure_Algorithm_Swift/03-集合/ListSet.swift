//
//  ListSet.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/11.
//

import Cocoa

class ListSet<E: Hashable & Comparable>: Set<E> {

    
    //MARK: - 属性
    fileprivate var linkList = DoubleLinkList<E>()
    
    
    //MARK: - override
    /**元素个数**/
    override func size() -> Int {
        return linkList.count
    }
    
    /**是否为空**/
    override func isEmpty() -> Bool {
        return linkList.isEmpty()
    }
    
    /**清除所有元素**/
    override func clear() {
        linkList.clear()
    }
    
    /**是否包含某元素**/
    override func contains(_ val: E) -> Bool {
        return linkList.contains(val)
    }
    
    /**添加元素**/
    override func add(val: E) {
        if !linkList.contains(val) { // 不存在才添加
            linkList.add(val)
        }
    }
    
    /**删除元素**/
    override func remove(val: E) {
        let index = linkList.indexOfElement(val)
        if index != Const.notFound { // 存在才删除
            linkList.remove(index)
        }
    }
    
    /**遍历所有元素**/
    override func traversal(setVisitor: ((E) -> ())? = nil) {
        for i in 0..<size() {
            if let node = linkList.get(i) {
                
                if let setVisitor {
                    setVisitor(node)
                }
            }
        }
    }
    
    /**获取所有元素**/
    override func allElements() -> [E] {
        var array = [E]()
        for i in 0..<size() {
            if let node = linkList.get(i) {
                array.append(node)
            }
        }
        return array
    }
}
