//
//  BinarySearch.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/17.
//

import Cocoa

class BinarySearch<T: Comparable>: Sort<T> {

    /*
     * 二分搜索查找索引
     * 先记录待插入的元素
     * 头部有序数列中比待插入元素大的, 都向后挪动一个位置
     * 将待插入元素放到合适的位置
     */
    override func sortAction() {
        
        for begin in 1..<dataArray.count {
            
            // 1、用二分搜索找到插入位置的ndex
            let insertIndex = searchInsertIndex(index: begin)
            
            // 2、将[insertIndex begin) 范围内的元素往右移动一个位置
            let value = dataArray[begin]
            for i in (insertIndex..<begin).reversed() {
                dataArray[i + 1] = dataArray[i] //
            }
            dataArray[insertIndex] = value
        }
    }
    
    
    /// 二分搜索, 根据索引搜索
    /// index之前的元素都是有序的
    /// index代表新插入的元素
    fileprivate func searchInsertIndex(index: Int) -> Int {
        var begin = 0
        var end = index
        while begin < end {
            let mid = (begin + end) >> 1
            if cmp(e1: dataArray[index], e2: dataArray[mid]) < 0 {
                end = mid
            } else {
                // 查找到最后面的相等的索引
                begin = mid + 1
            }
        }
        return begin
    }
}
