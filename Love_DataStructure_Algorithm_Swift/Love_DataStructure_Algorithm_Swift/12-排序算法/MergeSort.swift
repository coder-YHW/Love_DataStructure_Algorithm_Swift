//
//  MergeSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/26.
//

import Cocoa

/// 归并排序
class MergeSort<T: Comparable>: Sort<T> {

    fileprivate var leftArray = [T]()

    override func sortAction() {
        let mid = dataArray.count >> 1
        for i in 0..<mid {
            leftArray.append(dataArray[i])
        }
        
        sortRange(begin: 0, end: dataArray.count)
    }
    
    
    /**
     * 对 [begin, end) 范围的数据进行归并排序
     */
    fileprivate func sortRange(begin: Int, end: Int) {
        if end - begin < 2 { return }
        
        let mid = (begin + end) >> 1
        sortRange(begin: begin, end: mid)
        sortRange(begin: mid, end: end)
        mergeAction(begin: begin, mid: mid, end: end)
    }
    
    
    /**
     * 将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
     */
    fileprivate func mergeAction(begin: Int, mid: Int, end: Int) {
        // 1.1、左边数组索引 - 从原数组左边部份拷贝出来的新数组
        var leftIndex = 0
        let leftEnd = mid - begin
        // 1.2、右边数组索引 - 原数组右边部份
        var rigtnIndex = mid
        let rightEnd = end
        // 1.3原整个数组索引
        var dataArrayIndex = begin
        
        // 2、备份左边数组
        for i in leftIndex..<leftEnd {
            leftArray[i] = dataArray[i+begin]
        }
        
        // 3、右边数组跟左边数组比较 - 右比左小-顺序可以保证稳定性
        while leftIndex < leftEnd  { // 1.1、左边的排序完 右边的可以不用移动了
            
            // 3.1、右边的排序完 左边的会继续覆盖完
            if rigtnIndex < rightEnd && cmp(e1: dataArray[rigtnIndex], e2: leftArray[leftIndex]) < 0 {
                // 2.1、右边的小 拿右边数组的值去覆盖dataArray
                dataArray[dataArrayIndex] = dataArray[rigtnIndex]
                rigtnIndex += 1
                dataArrayIndex += 1
            }else {
                // 3.2、左边的小 拿左边数组的值去覆盖dataArray
                dataArray[dataArrayIndex] = leftArray[leftIndex]
                leftIndex += 1
                dataArrayIndex += 1
            }
        }
    }
}
