//
//  SingleLinkList.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

/// 单向链表
class SingleLinkList<E: Comparable>: AbstractList<E> {

    //MARK: - 属性
    /// first代表头指针 指向第一个节点
    fileprivate var first: ListNode<E>?
    
    
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
     * @return 原来的元素ֵ
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
        
        if index == 0 { // 1、没有前驱节点 ：添加第一个节点 或者 在头部插入节点 - 添加第一个节点 或者 在头部插入节点
            // 1、第一根线：first指向第一个节点 利用first创建新节点
            // 2、第二根线：将first指向新创建的节点
            first = ListNode(element: element, next: first)
        } else { // 2、有前驱节点 ：在中间 或着 尾部插入节点
            // 1、第一根线：找到前驱节点 利用前驱节点的.next 创建新节点
            // 2、第二根线：将前驱节点的.next 指向新创建的节点
            let prevNode = nodeOfIndex(index - 1)
            prevNode?.next = ListNode(element: element, next: prevNode?.next)
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
        
        var node = first
        if index == 0 { // 删除首节点
            // 1、第一根线：被删除的节点是first
            // 2、第二根线：将first指向first.next
            
            first = node?.next
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


// MARK: - 打印
extension SingleLinkList : CustomStringConvertible {
    
    var description: String {
        
        var text = "count = \(count), ["
        var currentNode = first
        
        for i in 0...count {
            if i != 0 {
                text += "->"
            }else if count != 0 {
                text += "first：->"
            }
            
            if let e = currentNode?.element {
                text += "\(e)"
            } else {
                text += "nil"
            }
            
            currentNode = currentNode?.next
        }
        
        text += "]"
        return text
    }
}


// MARK: - 练习题
extension SingleLinkList {
    /// 反转一个链表(迭代方式)
    func reverseLinkedListDie(header: ListNode<E>?) -> ListNode<E>? {
        if header == nil || header?.next == nil {
            return header
        }
        let newHeader = reverseLinkedListDie(header: header?.next)
        header?.next?.next = header
        header?.next = nil
        return newHeader
    }
    
    /// 反转一个链表(递归方式)
    func reverseLinkedList(header: ListNode<E>?) -> ListNode<E>? {
        var tmpHeader = header
        var newHeader: ListNode<E>? = nil
        while tmpHeader != nil {
            let next = tmpHeader?.next
            next?.next = newHeader
            newHeader = tmpHeader
            tmpHeader = next
        }
        return newHeader
    }
    
    /// 判断一个链表是否有环
    func hasCycle(_ head: ListNode<E>?) -> Bool {
        var slow = head?.next
        var fast = head?.next?.next
        while fast != nil && fast?.next != nil {
            if slow == fast {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
    
    /// 存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除所有重复的元素，使每个元素 只出现一次 。
    func deleteDuplicates(_ head: ListNode<E>?) -> ListNode<E>? {
        if head == nil { return head }
        
        var current = head
        while current?.next != nil {
            if current?.element == current?.next?.element {
                current?.next = current?.next?.next
            } else {
                current = current?.next
            }
        }
        return head
    }
    
    /// 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
    func mergeTwoLists(_ l1: ListNode<E>?, _ l2: ListNode<E>?) -> ListNode<E>? {
        let node1 = l1
        var node2 = l2
        
        while node1 != nil && node2 != nil {
            if let ele1 = node1?.element, let ele2 = node2?.element {
                if ele1 < ele2 {
                    node2 = node2?.next
                } else {
                    node1?.next = ListNode(element: node2?.element, next: node1?.next)
                    node2 = node2?.next
                }
            }
        }
        
        return node1
    }
}

