//
//  SingleDeque.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/15.
//

import Cocoa

/// 双端队列 - 用循环链表实现
class SingleDeque<E: Comparable> {
    
    //MARK: - 属性
    fileprivate var LinkList = DoubleLinkList<E>()
    
    
    //MARK: - 方法
    /// 元素数量
    func size() -> Int {
        return LinkList.count
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return LinkList.count == 0
    }
    
    /**清除所有元素*/
    func clear() {
        LinkList.clear()
    }
    
    /// 从队头入队
    func enQueueFront(_ element: E) {
        LinkList.add(by: 0, element: element)
    }
    
    /// 从队头出队
    func deQueueFront() -> E? {
        return LinkList.remove(0)
    }
    
    /// 从队尾入队
    func enQueueTail(_ element: E) {
        LinkList.add(element)
    }
    
    /// 从队尾出队
    func deQueueTail() -> E? {
        return LinkList.remove(LinkList.count - 1)
    }
    
    /// 获取队列的头元素
    func front() -> E? {
        return LinkList.get(0)
    }
    
    /// 获取队列的尾元素
    func tail() -> E? {
        return LinkList.get(LinkList.count - 1)
    }
}


// MARK: - 打印
extension SingleDeque : CustomStringConvertible {
    
    var description: String {
        return LinkList.description
    }
}
