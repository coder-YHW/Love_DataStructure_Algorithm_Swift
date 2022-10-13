//
//  QueueStack.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/13.
//

import Cocoa


/// 用2个队列实现栈操作 （inStack➕outStack）
class QueueStack<E: Comparable> {
    
    //MARK: - 属性
    fileprivate var queue = SingleQueue<E>()
    fileprivate var last = SingleQueue<E>()
    
    
    //MARK: - 方法
    /**元素个数*/
    func size() -> Int {
        return queue.size()
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return queue.isEmpty()
    }
    
    /**清空元素*/
    func clear() {
        queue.clear()
    }
    
    /// 入栈
    func push(_ element: E) {
        queue.enQueue(element)
    }
    
    /// 出栈
    @discardableResult
    func pop() -> E? {
        let tmpQueue = SingleQueue<E>()
        for _ in 0..<queue.size() - 1 {
            tmpQueue.enQueue(queue.deQueue()!)
        }
        let element = queue.deQueue()
        for _ in 0..<tmpQueue.size() {
            queue.enQueue(tmpQueue.deQueue()!)
        }
        return element
    }
    
    /// 获取栈顶元素
    func peek() -> E? {
        let tmpQueue = SingleQueue<E>()
        for _ in 0..<queue.size() - 1 {
            tmpQueue.enQueue(queue.deQueue()!)
        }
        let element = queue.front()
        for _ in 0..<tmpQueue.size() {
            queue.enQueue(tmpQueue.deQueue()!)
        }
        queue.enQueue(element!)
        return element
    }
    
    func toString() -> String {
        let count = queue.size()
        var text = "count = \(count), ["
        for i in 0..<count {
            if i != 0 {
                text += ", "
            }
            if let e = queue.deQueue() {
                text += "\(e)"
            } else {
                text += "nil"
            }
        }
        text += "]"
        return text
    }
}
