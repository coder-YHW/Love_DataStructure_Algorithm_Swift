//
//  GenericUnionFind.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/21.
//

import Cocoa

/// 泛型并查集
class GenericUnionFind<V: Hashable & Comparable> {

    
    //MARK: - 属性
    fileprivate let nodeMap = HashMap<V, UnionFindNode<V>>()
    
    
    //MARK: - 方法
    func makeSet(_ val: V) {
        if nodeMap.containsKey(key: val) { return }
        let node = UnionFindNode(val: val)
        nodeMap.put(key: val, val: node)
    }
    
    
    /// 查找V所属的集合(根节点)
    func find(val: V?) -> V? {
        let node = findNode(val)
        return node == nil ? nil : node?.value
    }
    
    /// 合并v1, v2所在的集合
    func union(v1: V?, v2: V?) {
        if let p1 = findNode(v1), let p2 = findNode(v2) {
            if p1.value == p2.value { return }
            
            if p1.rank < p2.rank {
                p1.parent = p2
            } else if p1.rank > p2.rank {
                p2.parent = p1
            } else {
                p1.parent = p2
                p2.rank += 1
            }
        }
    }
    
    /// 检查v1, v2是否属于同一个集合
    func isSame(v1: V?, v2: V?) -> Bool {
        return find(val: v1) == find(val: v2)
    }
}


extension GenericUnionFind {
    /// 找出Val的根节点
    fileprivate func findNode(_ val: V?) -> UnionFindNode<V>? {
        // 1、找到节点
        guard let value = val else { return nil }
        var node = nodeMap.get(key: value)
        if node == nil { return nil }
        
        // 2、找到节点的根节点
        while node?.value != node?.parent?.value {
            node?.parent = node?.parent?.parent
            node = node?.parent
        }
        
        return node
    }
}
