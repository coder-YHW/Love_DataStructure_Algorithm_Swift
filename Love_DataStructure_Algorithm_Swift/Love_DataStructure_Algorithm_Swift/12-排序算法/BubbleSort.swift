//
//  BubbleSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

/// 冒泡排序1
/// 平均、最坏复杂度O(n^2)  最好时间复杂度O(n) 空间复杂度O(1)
/// 稳定排序
class BubbleSort1<T: Comparable>: Sort<T> {
    
    /*
     * 正常排序
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较：351次 交换：204次
     */
    override func sortAction() {
        
        for end in (1...(dataArray.count-1)).reversed() {
            
            for begin in 1...end {
                
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                }
            }
        }
    }
}




/// 冒泡排序2 - 优化（如果排序过程中 已经有序 可以提前结束for循环）
class BubbleSort2<T: Comparable>: Sort<T> {
    
    /*
     * 判断是否已经是有序
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较：351次 交换：204次
     */
    override func sortAction() {
        
        for end in (1...(dataArray.count-1)).reversed() {
            
            var isSorted = true // 1、假定sorted = YES
            
            for begin in 1...end {
                
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                }
                
                isSorted = false // 2、更新sorted = NO
            }
            
            if isSorted { break } // 3、提前结束for循环
        }
    }
}

/// 冒泡排序3 - 优化（如果排序过程中 后面部分有序 可以减少for循环范围）
class BubbleSort3<T: Comparable>: Sort<T> {
    
    /*
     *  判断后面部分是否已经有序
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较：351次 交换：204次
     */
    override func sortAction() {
        
        for var end in (1...(dataArray.count-1)).reversed() {
            
            var sortedIndex = 1 // 1、假定sortedIndex = 1
            
            for begin in 1...end {
                
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                }
                 
                sortedIndex = begin // 2、更新sortedIndex = begin
            }
            
            end = sortedIndex // 3、减少for循环范围
        }
    }
}


