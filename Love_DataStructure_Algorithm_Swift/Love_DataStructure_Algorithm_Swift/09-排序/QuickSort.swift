//
//  QuickSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/26.
//

import Cocoa

/// 快速排序 - 逐渐将每一个元素都转换成轴点元素
class QuickSort<T: Comparable>: Sort<T> {

    
    override func sortAction() {
        quickSort(begin: 0, end: dataArray.count)
    }

    
    /**
     * 对 [begin, end) 范围的元素进行快速排序
     * @param begin
     * @param end
     */
    fileprivate func quickSort(begin: Int, end: Int) {
        if end - begin < 2 { return }
        
        // 1、构造出 [begin, end) 范围的轴点元素
        let pivot = pivotIndex(first: begin, last: end)
        
        // 2、对子序列再次快速排序
        quickSort(begin: begin, end: pivot)
        quickSort(begin: pivot + 1, end: end)
    }
    
    
    /**
     * 构造出 [begin, end) 范围的轴点元素
     * @return 轴点元素的最终位置
     * 为了避免分割出来的数列极度不均匀, 取一个随机的索引和第一个交换
     */
    fileprivate func pivotIndex(first: Int, last: Int) -> Int {
        // 随机的索引和first交换
        let random = Int.random(in: first..<last)
        swap(i1: random, i2: first)
        
        // 0、索引处理
        let pivotVal = dataArray[first]
        var begin = first
        var end = last - 1
        
        // 1、左右扫描
        while begin < end {
            
            // 1.1、从右往左扫描 <-
            while begin < end {
                if cmp(e1: pivotVal, e2: dataArray[end]) < 0 { // 轴点元素 < 右边元素 ： end--
                    end -= 1
                } else { // 轴点元素 >= 右边元素 : 调换位置
                    dataArray[begin] = dataArray[end]
                    begin += 1
                    break
                }
            }
            
            // 1.2、从左往右扫描 ->
            while begin < end {
                if cmp(e1: pivotVal, e2: dataArray[begin]) > 0 { // 轴点元素 > 左边元素 ： begin++
                    begin += 1
                } else { // 轴点元素 <= 左边元素 : 调换位置
                    dataArray[end] = dataArray[begin]
                    end -= 1
                    break
                }
            }
        }
        
        // 2、将轴点元素放入最终位置
        dataArray[begin] = pivotVal
        // 返回轴点元素最终位置
        return begin // begin = end
    }
}
