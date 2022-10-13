//
//  StackQueue.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/13.
//

import Cocoa


/// 用2个栈实现队列操作 （inStack➕outStack）
class StackQueue<E: Comparable> {
    
    //MARK: - 属性
    fileprivate var inStack = Statck<E>()
    fileprivate var outStack = Statck<E>()
    
    
    //MARK: - 方法
    /**元素个数*/
    func size() -> Int {
        return inStack.size() + outStack.size()
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return inStack.isEmpty() && outStack.isEmpty()
    }
    
    /**清空元素*/
    func clear() {
        
        while !inStack.isEmpty() {
            inStack.pop()
        }
        
        while !outStack.isEmpty() {
            outStack.pop()
        }
    }
    
    /** 入队 */
    func enQueue(element: E) {
        inStack.push(element)
    }
    
    /// 出队
    @discardableResult
    func deQueue() -> E? {

        // 0、队列为空
        if isEmpty() {
            return nil
        }
        
        // 1、outStack不为空 从outStack出队
        if !outStack.isEmpty() {
            return outStack.pop()
        }
        
        // 2、outStack为空 inStack不为空
        // 将inStack的元素全部压入outStack
        while !inStack.isEmpty() {
            outStack.push(inStack.pop())
        }
        
        // 3、再弹出outStack栈顶元素
        return outStack.pop()
    }
    
    /// 获取栈顶元素
    func peek() -> E? {

        // 0、队列为空
        if isEmpty() {
            return nil
        }
        
        // 1、outStack不为空 从outStack出队
        if !outStack.isEmpty() {
            return outStack.peek()
        }
        
        // 2、outStack为空 inStack不为空
        // 将inStack的元素全部压入outStack
        while !inStack.isEmpty() {
            outStack.push(inStack.pop())
        }
        
        // 3、再弹出outStack栈顶元素
        return outStack.peek()
    }

}


// MARK: - 打印
extension StackQueue : CustomStringConvertible {
    
    var description: String {
        return "inStack:\(inStack.description) \n outStack:\(outStack.description)"
    }
}
