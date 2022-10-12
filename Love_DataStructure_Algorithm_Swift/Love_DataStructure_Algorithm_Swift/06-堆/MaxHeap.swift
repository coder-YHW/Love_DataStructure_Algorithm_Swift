//
//  MaxHeap.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/30.
//

import Cocoa


/// 最大堆
class MaxHeap<E: Comparable>: BinaryHeap<E> {

    convenience init(vals: [E] = []) {
        self.init(vals: vals, compare: { $0 > $1 })
    }
}

