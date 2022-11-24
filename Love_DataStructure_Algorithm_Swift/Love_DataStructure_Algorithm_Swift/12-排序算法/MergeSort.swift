//
//  MergeSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/26.
//

import Cocoa

/// 归并排序 = 分割操作 ➕ 合并操作
/// 时间复杂度O(nlogn) 空间复杂度O(n)
class MergeSort<T: Comparable>: Sort<T> {

    fileprivate var leftArray = [T]()

    //MARK: - 归并排序
    override func sortAction() {
        let mid = dataArray.count >> 1
        for i in 0..<mid {
            // 此处只是创建一个长度是dataArray一半的辅助数组leftArray
            // 除了复用辅助数组的内存空间外 没有任何其他特殊含义
            leftArray.append(dataArray[i])
        }
        
        divideAction(begin: 0, end: dataArray.count)
    }
    
    //MARK: 1、分割操作
    /**
     * 一、divideAction-分割操作
     * 将 [begin, end) 范围的数据进分割成 [begin, mid) 与 [mid, end)两部分
     * 合并排序好之后的 [begin, mid) 与 [mid, end)两部分数据
     */
    fileprivate func divideAction(begin: Int, end: Int) {
        // 递归基
        if end - begin < 2 { return }
        
        let mid = (begin + end) >> 1
        divideAction(begin: begin, end: mid) // 分割操作
        divideAction(begin: mid, end: end)   // 分割操作
        mergeAction(begin: begin, mid: mid, end: end) // 合并操作
    }
    
    //MARK: 2、合并操作
    /**
     * 二、mergeAction - 合并操作
     * 将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
     * merge原理 跟 【88-合并两个有序数组】很相似
     */
    fileprivate func mergeAction(begin: Int, mid: Int, end: Int) {
        
        // 1、将要合并的左边数组元素 从dataArray拷贝到leftArray中
        for i in 0..<(mid-begin) {
            leftArray[i] = dataArray[i+begin]
        }
        
        // 2、左边数组跟右边数组顺序比较大小 - （右比左小-顺序可以保证稳定性）
        var leftIndex = 0     // 左边数组指针：在leftArray中的index：[0, mid-begin)
        var rigtnIndex = mid  // 右边数组指针：在dataArray中的index：[mid, end)
        var currIndex = begin // 插入位置指针：在dataArray中的index：[begin, end)
        
        while leftIndex < (mid-begin)  { // 左边数组的排序完 右边数组是有序的的可以不用移动了
            
            // 3.1、右边的排序完 左边的会继续覆盖完
            if rigtnIndex < end && cmp(e1: dataArray[rigtnIndex], e2: leftArray[leftIndex]) < 0 {
                // 2.1、右边的小 拿右边数组的值去覆盖dataArray
                dataArray[currIndex] = dataArray[rigtnIndex]
                rigtnIndex += 1
                currIndex += 1
            }else {
                // 3.2、左边的小 拿左边数组的值去覆盖dataArray
                dataArray[currIndex] = leftArray[leftIndex]
                leftIndex += 1
                currIndex += 1
            }
        }
    }
}
