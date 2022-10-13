//
//  CircleDeque.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/15.
//

import Cocoa

/// 双端循环队列 - 用优化后的动态数组实现
class CircleDeque<E: Comparable> {

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
    
    /// 从队头入队
    func enQueueFront(_ element: E) {
        arrayList.add(by: 0, element: element)
    }
    
    /// 从队尾入队
    func enQueueTail(_ element: E) {
        arrayList.add(element)
    }
    
    /// 从队头出队
    func deQueueFront() -> E? {
        arrayList.remove(0)
    }
    
    /// 从队尾出队
    func deQueueTail() -> E? {
        arrayList.remove(arrayList.count - 1)
    }
    
    /// 获取队列的头元素
    func front() -> E? {
        return arrayList.get(0)
    }
    
    /// 获取队列的尾元素
    func tail() -> E? {
        return arrayList.get(arrayList.count - 1)
    }
}


//MARK: - 打印 
extension CircleDeque : CustomStringConvertible {
    
    var description: String {
        return arrayList.description
    }
}
