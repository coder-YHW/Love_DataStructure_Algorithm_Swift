//
//  UnionFind_QF.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/19.
//

import Cocoa

/// Quick Find
class UnionFind_QF: UnionFind {

    /// 父节点就是根节点 - 时间复杂度O(1)
    override func find(v: Int) -> Int {
        rangeCheck(v: v)
        return parents[v]
    }
    
    /// 将v1所在集合的所有元素都嫁接到v2的父节点上  - 时间复杂度O(n)
    override func union(v1: Int, v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)
        if p1 == p2 { return }
        
        for i in 0..<parents.count {
            if parents[i] == p1 { // 替换父节点
                parents[i] = p2
            }
        }
    }
}
