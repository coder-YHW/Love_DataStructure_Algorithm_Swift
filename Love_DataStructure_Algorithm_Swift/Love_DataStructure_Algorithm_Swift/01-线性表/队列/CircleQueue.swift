//
//  CircleQueue.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/15.
//

import Cocoa

/// 单端循环队列 - 用优化后的动态数组实现
class CircleQueue<E: Comparable> {

    //MARK: - 属性
    fileprivate var arrayList = ArrayListUpgrade<E>()
    
    
    //MARK: - 方法
    /// 元素数量
    func size() -> Int {
        return arrayList.count
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return arrayList.isEmpty()
    }
    
    /**清除所有元素*/
    func clear() {
        arrayList.clear()
    }
    
    /// 入队
    func enQueue(_ element: E) {
        arrayList.add(element)
    }

    /// 出队
    func deQueue() -> E? {
        return arrayList.remove(0)
    }

    /// 获取队列的头元素
    func header() -> E? {
        return arrayList.get(0)
    }
    
}


//MARK: - 打印 
extension CircleQueue : CustomStringConvertible {
    
    var description: String {
        return arrayList.description
    }
}
