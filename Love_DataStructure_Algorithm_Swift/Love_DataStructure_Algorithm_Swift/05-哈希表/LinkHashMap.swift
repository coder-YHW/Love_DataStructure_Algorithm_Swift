//
//  LinkHashMap.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/16.
//

import Cocoa

/// HashMap的基础上维护元素添加顺序 使得遍历结果是遵从添加顺序的
/// 1、添加修复LinkHashMap性质 - 重写createNode构造函数
/// 2、删除修复LinkHashMap性质 - 重写fixLinkHashMapAfterRemove1和fixLinkHashMapAfterRemove2
/// 3、clear时 记得清空first和last指针
class LinkHashMap<K: Hashable & Comparable, V: Comparable>: HashMap<K, V> {

    //MARK: - 属性
    var first: LinkHashNode<K, V>?
    var last : LinkHashNode<K, V>?
    
    //MARK: - 子类重写
    override func createNode(_ key: K?, _ val: V?, parent: HashNode<K, V>? = nil) -> HashNode<K, V> {
        
        let node = LinkHashNode(key, val, parent: parent as? LinkHashNode)
        
        // 1、修复LinkHashMap性质 双向链表 - 往链表最后面添加元素
        if let prev = last { // 添加的其他元素
            prev.next = node
            node.prev = prev
            last = node
        }else { // 添加的第一个元素
            first = node
            last = node
        }
        
        return node
    }
    
    /// 修复LinkHashMap性质  子类重写 ( 删除度为1或0的节点 node)
    public override func fixLinkHashMapAfterRemove1(_ node: HashNode<K, V>) {

        // 双向链表 - 维护2根线
        let node = node as? LinkHashNode
        
        let prev = node?.prev
        let next = node?.next
        
        // 维护右向线-> prev?.next
        if prev == nil {
            first = next
        }else {
            prev?.next = next
        }
        
        // 维护左向线<- next?.prev
        if next == nil {
            last = prev
        }else {
            next?.prev = prev
        }
    }
    
    /// 修复LinkHashMap性质 - 子类重写 ( 删除度为2的节点 node)
    public override func fixLinkHashMapAfterRemove2(_ node: HashNode<K, V>, _ replaceNode: HashNode<K, V>) {
        // 思路：交换node和replaceNode在双向链表中的位置
        // 只是替换 不是删除 更新线时不用从prev指向next 指向自己就可以了
        
        // 0、类型转换
        let node = node as? LinkHashNode
        let replaceNode = node as? LinkHashNode
        
        // 1.1、交换prev
        let tmpPrev = node?.prev
        node?.prev = replaceNode?.prev
        replaceNode?.prev = tmpPrev
        // 1.2、交换next
        let tmpNext = node?.next
        node?.next = replaceNode?.next
        replaceNode?.next = tmpNext
        
        // 2、维护node的2根线
        let prev1 = node?.prev
        let next1 = node?.next
        
        // 2.1、维护右向线-> prev?.next
        if prev1 == nil {
            first = node
        }else {
            prev1?.next = node
        }
        
        // 2.2、维护左向线<- next?.prev
        if next1 == nil {
            last = node
        }else {
            next1?.prev = node
        }
        
        // 3、维护replaceNode的2根线
        let prev2 = replaceNode?.prev
        let next2 = replaceNode?.next
        
        // 3.1、维护右向线-> prev?.next
        if prev2 == nil {
            first = replaceNode
        }else {
            prev2?.next = replaceNode
        }
        
        // 3.2、维护左向线<- next?.prev
        if next2 == nil {
            last = replaceNode
        }else {
            next2?.prev = replaceNode
        }
    }
    
    
    /**清除所有元素*/
    override func clear() {
        super.clear()
        
        first = nil
        last = nil
    }
    
    /**按照链表顺序遍历 */
    // HashMap所有遍历都可以改为linkList的遍历
    override func traversal(visitor : ((K?, V?) -> ())) {
        
        var node = first
        
        while node != nil {
            
            visitor(node?.key, node?.val)
            
            node = node?.next
        }
    }
}

//MARK: - HashMap所有遍历都可以改为linkList的遍历
