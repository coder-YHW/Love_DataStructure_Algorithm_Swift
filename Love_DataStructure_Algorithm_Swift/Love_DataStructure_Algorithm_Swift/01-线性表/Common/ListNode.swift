//
//  ListNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/10.
//

import Cocoa


/// 链表节点
class ListNode<E: Comparable>: NSObject {

    var element: E?
    var prev: ListNode?
    var next: ListNode?
    
    init(element: E?, next: ListNode?, prev: ListNode? = nil) { // 参数可选类型，默认值为nil
        
        self.element = element
        self.prev = prev
        self.next = next
    }

}
