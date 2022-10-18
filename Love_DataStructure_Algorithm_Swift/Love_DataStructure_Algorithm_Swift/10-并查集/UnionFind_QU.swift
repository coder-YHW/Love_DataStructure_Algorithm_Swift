//
//  UnionFind_QU.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/19.
//

import Cocoa

/// Quick Union
class UnionFind_QU: UnionFind {

    /// 通过parent链条不断地向上找，直到找到根节点  - 时间复杂度O(nlogn)
    override func find(v: Int) -> Int {
        rangeCheck(v: v)
        
        var val = v
        while val != parents[val] {
            val = parents[val]
        }
        return val
    }
    
    /// 将v1的根节点嫁接到v2的根节点上- 时间复杂度O(nlogn)
    override func union(v1: Int, v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)
        if p1 == p2 { return }
        
        // 替换根节点
        parents[p1] = p2
    }
}
