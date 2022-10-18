//
//  UnionFind_QU_Rank_PC.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/20.
//

import Cocoa

/*
 * Quick Union - 基于rank的优化, 路径压缩
 * 矮的树嫁接到高的树
 * 路径压缩: 在find时是路径上的所有节点都指向根节点, 从而降低树的高度
 */
class UnionFind_QU_Rank_PC: UnionFind_QU_Rank {

    override func find(v: Int) -> Int {
        rangeCheck(v: v)
        
        if parents[v] != v {
            let parent = parents[v]
            let root   = find(v: parent)
            parents[v] = root // 递归调用 - 沿着父节点继续往上找 使路径上的所有节点都指向根节点, 从而降低树的高度
        }
        
        return parents[v]
    }
}
