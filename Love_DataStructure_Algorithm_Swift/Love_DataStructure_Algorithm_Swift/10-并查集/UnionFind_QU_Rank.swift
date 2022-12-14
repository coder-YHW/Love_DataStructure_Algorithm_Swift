//
//  UnionFind_QU_Rank.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/20.
//

import Cocoa

/*
 * Quick Union - 基于rank的优化
 * 矮的树嫁接到高的树
 */
class UnionFind_QU_Rank: UnionFind_QU {

    /// 存储集合的树的高度
    fileprivate var rankArr = [Int]()
    
    override init(capacity: Int) {
        super.init(capacity: capacity)
        
        rankArr = Array(repeating: 1, count: capacity)
    }
    
    
    /// 将v1的根节点嫁接到v2的根节点上
    override func union(v1: Int, v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)
        if p1 == p2 { return }
        
        if rankArr[p1] < rankArr[p2] {
            parents[p1] = p2
        } else if rankArr[p2] < rankArr[p1] {
            parents[p2] = p1
        } else { // rank1 = rank2
            parents[p1] = p2 // 2种都可以
            
            rankArr[p2] += 1 // 更新rank
        }
    }
}
