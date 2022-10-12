//
//  MinHeap.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/30.
//

import Cocoa

/// 最小堆
class MinHeap<E: Comparable>: BinaryHeap<E> {

    convenience init(vals: [E] = []) {
        self.init(vals: vals, compare: { $0 < $1 })
    }
}
