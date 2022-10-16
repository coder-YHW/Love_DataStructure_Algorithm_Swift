//
//  HeapSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

/// 堆排序 - 选择排序进阶版
class HeapSort<T: Comparable>: Sort<T> {
    
    /// 堆元素个数
    fileprivate var heapCount = 0
    
    /// 通过堆排序
    override func sortAction() {
        
        heapCount = dataArray.count
        
        // 创建堆
        let lastIndex = heapCount >> 1 - 1
        for i in (0...lastIndex).reversed() {  // 0 <= i <= (heapCount/2 - 1)
            siftDown(i)
        }
        
        while heapCount > 1 { // heapCount > 1
            // 交换堆顶元素和尾部元素
            swap(i1: 0, i2: heapCount - 1)
            heapCount -= 1
            siftDown(0)
        }
    }
    
    /// 下滤
    fileprivate func siftDown(_ index: Int) {
        let value = dataArray[index]
        let half = heapCount >> 1
        var currentIndex = index
        
        // 是否还有父节点
        while currentIndex < half {
            // 左子节点索引
            var childIndex = currentIndex << 1 + 1
            var childVal = dataArray[childIndex]
            
            // 右子节点索引
            let rightIndex = childIndex + 1
            
            // 如果存在右子节点 >
            if rightIndex < heapCount && cmp(e1: dataArray[rightIndex], e2: childVal) > 0 {
                childIndex = rightIndex
                childVal = dataArray[rightIndex]
            }
            
            // 比子节点都大
            if cmp(e1: childVal, e2: value) <= 0 { break }
                
            dataArray[currentIndex] = childVal
            currentIndex = childIndex
        }
        
        dataArray[currentIndex] = value
    }
}
