//
//  SingleQueue.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/15.
//

import Cocoa

/// 单端队列 - 用动态数组实现
class SingleQueue<E: Comparable> {

    //MARK: - 属性
    fileprivate var arrayList = ArrayList<E>()
    
    
    //MARK: - 方法
    /// 元素数量
    func size() -> Int {
        return arrayList.count
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return arrayList.count == 0
    }
    
    /**清除所有元素*/
    func clear() {
        arrayList.clear()
    }
    
    /// 入队
    func enQueue(_ element: E?) {
        if let tmp = element {
            arrayList.add(tmp)
        }
    }
    
    /// 出队
    func deQueue() -> E? {
        var element: E?
        if arrayList.count > 0 {
            element = arrayList.remove(0)
        }
        return element
    }
    
    /// 获取队列的头元素
    func front() -> E? {
        return arrayList.get(0)
    }
}


// MARK: - 打印
extension SingleQueue : CustomStringConvertible {
    
    var description: String {
        return arrayList.description
    }
}
