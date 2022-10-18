//
//  UnionFind_QU_Size.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/20.
//

import Cocoa

/*
 * Quick Union - 基于size的优化
 * 元素少的树嫁接到元素多的树
 */
class UnionFind_QU_Size: UnionFind_QU {

    /// 存储集合的元素个数
    fileprivate var sizeArr = [Int]()
    
    
    override init(capacity: Int) {
        super.init(capacity: capacity)
        
        sizeArr = Array(repeating: 1, count: capacity)
    }
    
    /// 将v1的根节点嫁接到v2的根节点上
    override func union(v1: Int, v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)
        if p1 == p2 { return }
        
        // 节点少的合并到节点多的
        if sizeArr[p1] < sizeArr[p2] {
            parents[p1] = p2
            
            sizeArr[p2] += sizeArr[p1] // 更新size
        } else {
            parents[p2] = p1
            
            sizeArr[p1] += sizeArr[p2] // 更新size
        }
    }
}
