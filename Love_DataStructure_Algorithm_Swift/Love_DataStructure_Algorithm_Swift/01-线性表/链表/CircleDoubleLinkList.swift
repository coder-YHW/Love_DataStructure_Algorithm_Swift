//
//  CircleDoubleLinkList.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/10.
//

import Cocoa

/// 双向循环链表
class CircleDoubleLinkList<E: Comparable>: AbstractList<E> {

    //MARK: - 属性
    /// first代表头指针 指向第一个节点
    fileprivate var first: ListNode<E>?
    /// last代表尾指针 指向最后一个节点
    fileprivate var last: ListNode<E>?
    
    //MARK:  循环链表属性增强
    /// curren代表指针现在的指针 指向当前所在的节点
    fileprivate var current: ListNode<E>?
    
    
    //MARK: - override
    /**
     * 清除所有元素
     */
    override func clear() {
        first = nil
        last = nil
        count = 0
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
        
        // 前半部分 ➕ 后半部分
        if index < count >> 1 { // 前半部分 - 顺序遍历 0 <= i < index
            
            var node = first
            for _ in 0..<index {
                node = node?.next
            }
            return node
            
        }else { // 后半部分 - 逆序遍历  (index + 1) <= i < count
         
            var node = last
            for _ in (index+1..<count).reversed() {
                node = node?.prev
            }
            return node
        }
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
        
        let currentNode = nodeOfIndex(index)
        let oldElement = currentNode?.element
        currentNode?.element = element
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
        
        if (index == 0) { // 1、往表头添加一个节点
          
            let oldFirst = first
            first = ListNode(element: element, next: oldFirst, prev: last)
        
            if (oldFirst == nil) { // 1.1、添加第一个节点
                last = first
                first?.prev = first
                last?.next = first
            }else { // 1.2、往表头添加一个节点
                oldFirst?.prev = first
                last?.next = first
            }
            
        } else if index == count { // 2、往表尾添加一个节点
            
            let oldLast = last
            last = ListNode(element: element, next: first, prev: oldLast)
            
            if (oldLast == nil) { // 2.1、添加第一个节点（重复判断 - 可以省略）
                first = last
                first?.prev = last
                last?.next = last
            }else { // 2.2、往表尾添加一个节点
                oldLast?.next = last
                first?.prev = last
            }
            
        } else { // 3、在中间插入节点 - 前后都有节点
            
            let nextNode = nodeOfIndex(index) // 获取后继节点 - 肯定存在
            let prevNode = nextNode?.prev // 获取前驱节点 - 肯定存在
            let currNode = ListNode(element: element, next: nextNode, prev: prevNode)
            prevNode?.next = currNode
            nextNode?.prev = currNode
        }
        
        count += 1
    }
    
    /**
     * 删除index位置的元素
     */
    override func remove(_ index: Int) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        let currentNode = nodeOfIndex(index)
        if count == 1 {
            first = nil
            last = nil
        } else {
            let befer = currentNode?.prev
            let after = currentNode?.next
            
            befer?.next = after
            after?.prev = befer
            if currentNode == first {
                first = after
            }
            if currentNode == last {
                last = befer
            }
        }
        
        count -= 1
        return currentNode?.element
    }

}

// MARK: - 循环链表方法增强
extension CircleDoubleLinkList {
    
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
extension CircleDoubleLinkList : CustomStringConvertible {
    
    var description: String {
        
        var text = "count = \(count), ["
        var currNode = first
        
        for i in 0..<count {
            if i != 0 {
                text += "<->"
            }else if count != 0 {
                text += "first：last-prev<->"
            }
            
            if let e = currNode?.element {
                text += "\(e)"
            } else {
                text += "nil"
            }
            
            currNode = currNode?.next
        }
        
        if count != 0 {
            text += "<->next-first: last"
        }
        
        text += "]"
        return text
    }
}
