//
//  UnionFind_QU_Rank_PH.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/20.
//

import Cocoa


/*
 * Quick Union - 基于rank的优化, 路径减半
 * 矮的树嫁接到高的树
 * 路径减半: 使路径上每隔一个节点就指向其祖父节点
 */
class UnionFind_QU_Rank_PH: UnionFind_QU_Rank {

    override func find(v: Int) -> Int {
        rangeCheck(v: v)
        
        var val = v
        if parents[val] != val {
            let parent = parents[val]
            let grand  = parents[parent]
            parents[val] = grand
            
            val = grand // 沿着祖父节点 使路径上每隔一个节点就指向其祖父节点
        }
        return val
    }
}
