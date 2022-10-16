//
//  LinkHashNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/16.
//

import Cocoa

// HashNode的基础上维护元素添加顺序 使得遍历结果是遵从添加顺序的
class LinkHashNode<K: Hashable, V: Comparable>: HashNode<K, V> {

    //MARK: - 属性
    var prev: LinkHashNode<K, V>?
    var next: LinkHashNode<K, V>?
    
    //MARK: - 构造函数
    init(_ key: K?, _ val: V?, parent: LinkHashNode? = nil) {
        super.init(key, val, parent: parent)
    }

}
