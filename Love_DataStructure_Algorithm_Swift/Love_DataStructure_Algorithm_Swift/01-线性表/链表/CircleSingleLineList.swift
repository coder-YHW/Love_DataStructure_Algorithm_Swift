//
//  CircleSingleLineList.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/10.
//

import Cocoa

/// 单向循环链表
class CircleSingleLineList<E: Comparable>: AbstractList<E> {
    
    //MARK: - 属性
    /// first代表头指针 指向第一个节点
    fileprivate var first: ListNode<E>?
    
    //MARK:  循环链表属性增强
    /// curren代表指针现在的指针 指向当前所在的节点
    fileprivate var current: ListNode<E>?
    
    
    //MARK: - override
    /**
     * 清除所有元素
     */
    override func clear() {
        count = 0
        first = nil
    }
    
    /**
     * 查看元素的索引
     */
    override func indexOfElement(_ element: E?) -> Int {
        
        var node = first
        for i in 0..<count {
            
            if let node, node.element == element { // 条件判断中的可选类型：1、先可选绑定 2、再写判断条件 3、用,隔开
                return i
            } else if element == nil {
                return i
            }
            
            node = node?.next
        }
        
        
        return Const.notFound
    }
    
    /// 获取index位置对应的节点对象
    fileprivate func nodeOfIndex(_ index: Int) -> ListNode<E>? {
        if rangeCheck(index) {
            return nil
        }

        var node = first
        for _ in 0..<index { // 顺序遍历 0 <= i < index
            node = node?.next
        }
        
        return node
    }
    
    /**
     * 获取index位置的元素
     */
    override func get(_ index: Int) -> E? {
        let node = nodeOfIndex(index)
        return node?.element
    }
    
    /**
     * 替换index位置的元素
     */
    override func set(by index: Int, element: E) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        let current = nodeOfIndex(index)
        let oldElement = current?.element
        current?.element = element
        return oldElement
    }
    
    
    //MARK: - 添加删除
    /**
     * 在index位置插入一个元素
     */
    override func add(by index: Int, element: E) {
        if rangeCheckForAdd(index) {
            return
        }
        
        if index == 0 {// 添加首节点
            // 1、第一根线：self.first指向第一个节点 利用self.first创建新节点
            // 2、第二根线：将self.first指向新创建的节点
            // 3、第三根线：将lastNode?.next指向first 或者 first?.next指向first
            
            // 0、保存修改first指针之前的lastNode
            let lastNode = count == 0 ? nil : nodeOfIndex(count - 1)
            
            first = ListNode(element: element, next: first)
            
            if count == 0 { // 1、first?.next指向first
                first?.next = first
            }else {
                // 2、lastNode?.next指向first
//                let lastNode = nodeOfIndex(count - 1) // 注意调用顺序
                lastNode?.next = first
            }
            
        } else {// 添加其他节点
            // 1、第一根线：找到前驱节点 利用前驱节点的.next 创建新节点
            // 2、第二根线：将前驱节点的.next 指向新创建的节点
            
            let prevNode = nodeOfIndex(index - 1)
            prevNode?.next = ListNode(element: element, next: prevNode?.next)
        }
        
        count += 1
    }
    
    /**
     * 删除index位置的元素
     * @param index
     * @return
     */
    override func remove(_ index: Int) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        var node = first
        if index == 0 {// 删除首节点
            // 1、第一根线：被删除的节点是self.first
            // 2、第二根线：将self.first指向self.first.next
            // 3、第三根线：将lastNode?.next指向first 或者 first指向nil
            
            if count == 1 {
                first = nil
            }else {
                let lastNode = nodeOfIndex(count - 1) // 注意调用顺序
                first = node?.next
//                let lastNode = nodeOfIndex(count - 1)
                lastNode?.next = first
            }
            
        } else {// 删除其他节点
            // 1、第一根线：找到node的前驱节点prev  此时prev.next就是被删除的节点
            // 2、第二根线：将前驱节点的prev.next 指向node.next
            
            let prevNode = nodeOfIndex(index - 1)
            node = prevNode?.next
            prevNode?.next = node?.next
        }
        
        count -= 1
        
        return node?.element
    }
}


// MARK: - 循环链表方法增强
extension CircleSingleLineList {
    
    /// 重置current指针
    public func reset() {
        current = first
    }
    
    /// 下一步
    public func next() {
        
        if (current == nil) {
            return
        }
            
        current = current?.next
    }
    
    /// 删除当前current节点
    public func removeCurrent() -> E? {
     
        // 已经删完了
        if current == nil {
            return nil
        }
        
        // 保存下一个节点
//        let nextNode = count == 1 ? nil : current?.next;
        let nextNode = current?.next;
        
        // 删除current节点
        let index = indexOfElement(current?.element)
        let element = remove(index)

        // current指向下一个节点
        if count == 0 {
            return nil
        }else {
            current = nextNode
        }
        
        
        return element
    }
    
}


// MARK: - 打印
extension CircleSingleLineList : CustomStringConvertible {
    
    var description: String {
        
        var text = "count = \(count), ["
        var currentNode = first
        
        for i in 0..<count {
            if i != 0 {
                text += "->"
            }else if count != 0 {
                text += "first：->"
            }
            
            if let e = currentNode?.element {
                text += "\(e)"
            }
            
            currentNode = currentNode?.next
        }
        
        if count == 0 {
            text += "]"
        } else {
            text += "-> :first]"
        }
        
        return text
    }
}
