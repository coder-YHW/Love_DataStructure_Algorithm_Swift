//
//  QueueStack.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/13.
//

import Cocoa


/// 用2个队列实现栈操作 （QueueStack➕tempQueue）
class QueueStack<E: Comparable> {
    
    //MARK: - 属性
    fileprivate var dataQueue = SingleQueue<E>()
    fileprivate var tempQueue = SingleQueue<E>()
    
    
    //MARK: - 方法
    /**元素个数*/
    func size() -> Int {
        return dataQueue.size()
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return dataQueue.isEmpty()
    }
    
    /**清空元素*/
    func clear() {
        dataQueue.clear()
    }
    
    /// 入栈
    func push(_ element: E) {
        dataQueue.enQueue(element)
    }
    
    /// 出栈
    @discardableResult
    func pop() -> E? {
        
        // 0、栈为空
        if dataQueue.isEmpty() {
            return nil
        }
        
        // 1、将dataQueue元素留最后一个 其他都出队到tempQueue
        for _ in 0..<(dataQueue.size() - 1) {
            tempQueue.enQueue(dataQueue.deQueue())
        }
        
        // 2、将tempQueue元素都出队到dataQueue
        for _ in 0..<tempQueue.size() {
            dataQueue.enQueue(tempQueue.deQueue())
        }
        
        // 3、将dataQueue队头元素出队
        return dataQueue.deQueue()
    }
    
    /// 获取栈顶元素
    func peek() -> E? {
        
        // 0、栈为空
        if dataQueue.isEmpty() {
            return nil
        }
        
        // 1、将dataQueue元素留最后一个 其他都出队到tempQueue
        for _ in 0..<(dataQueue.size() - 1) {
            tempQueue.enQueue(dataQueue.deQueue())
        }
        
        // 2、将dataQueue最后一个元素element出队 零时保存
        let element = dataQueue.deQueue()
        
        // 3、将tempQueue元素都出队到dataQueue
        for _ in 0..<tempQueue.size() {
            dataQueue.enQueue(tempQueue.deQueue())
        }
        
        // 4、将tdataQueue最后一个元素element入队到dataQueue
        dataQueue.enQueue(element)
        
        // 5、将dataQueue最后一个元素element返回
        return element
    }
}

// MARK: - 打印
extension QueueStack : CustomStringConvertible {
    
    var description: String {
        return dataQueue.description
    }
}
