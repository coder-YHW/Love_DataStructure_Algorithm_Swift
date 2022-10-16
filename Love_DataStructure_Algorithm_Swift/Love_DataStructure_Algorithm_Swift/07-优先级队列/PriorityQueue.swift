//
//  PriorityQueue.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/30.
//

import Cocoa

class PriorityQueue<E: Comparable> {

    
    //MARK: - 属性
    fileprivate var heap = BinaryHeap<E>()
    
    
    //MARK: - 构造函数
    init(compare: ((E, E) -> Bool)? = nil) {
        heap = BinaryHeap(compare: compare)
    }
    
    
    //MARK: - 方法
    /// 元素的数量
    func count() -> Int {
        return heap.count()
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return heap.isEmpty()
    }
    
    /**清空元素*/
    func clear() {
        heap.clear()
    }
    
    /// 入队
    func enQueue(_ val: E) {
        heap.add(val: val)
    }
    
    /// 出队
    func deQueue(_ val: E) -> E? {
        return heap.remove()
    }

    /// 获取队头元素
    func front() -> E? {
        return heap.getTop() // 获取堆顶元素
    }
}
