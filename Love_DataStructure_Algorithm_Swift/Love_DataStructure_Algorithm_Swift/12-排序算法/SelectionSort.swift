//
//  SelectionSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/26.
//

import Cocoa

/// 选择排序
/// 选择排序 - 平均、最坏、最好复杂度O(n^2)    空间复杂度O(1)
/// 非稳定排序
class SelectionSort<T: Comparable>: Sort<T> {
    
    /// 从序列中找出最大的元素放到最后, 以此类推
    override func sortAction() {
        
        for end in (1...(dataArray.count-1)).reversed() {
            
            var maxIndex = 0 // 1、假定最大值索引 = 0
            
            for begin in 1...end {
                
                if cmp(i1: maxIndex, i2: begin) < 0 { // 注意这一句
                    maxIndex = begin // 2、更新最大值索引 = begin
                }
            }
            
            swap(i1: maxIndex, i2: end) // 3、交换最大值索引与end的值
        }
    }
}
