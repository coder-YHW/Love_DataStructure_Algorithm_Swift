//
//  InsertionSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/26.
//

import Cocoa


/// 插入排序 - 平均、最坏时间复杂度O(n^2)、最好时间复杂度O(n)    空间复杂度O(1)
/// 插入排序时间复杂度跟逆序对成正比关系
/// 稳定排序

//MARK: - 插入排序-写法一
class InsertionSort1<T: Comparable>: Sort<T> {

    /*
     * 插入排序会将数列分为两个部分, 头部是已经排序好的, 尾部是待排序的部分
     * 从头开始扫描每一个元素, 只要比头部的数据小, 就插入到头部一个合适的位置
     * 比较次数：351 交换次数：204
     */
    override func sortAction() {
        for begin in 1..<dataArray.count {
            var current = begin
            while current > 0 && cmp(i1: current, i2: current - 1) < 0 {
                swap(i1: current, i2: current - 1)
                current -= 1
            }
        }
    }
}

//MARK:  插入排序-写法二
class InsertionSort2<T: Comparable>: Sort<T> {

    /*
     * 插入排序会将数列分为两个部分, 头部是已经排序好的, 尾部是待排序的部分
     * 从头开始扫描每一个元素, 只要比头部的数据小, 就插入到头部一个合适的位置
     * 有序部分已经有序师 break
     * //比较次数：225 交换次数：204 
     */
    override func sortAction() {
        for begin in 1..<dataArray.count {
            var current = begin
            while current > 0 {
                if cmp(i1: current, i2: current - 1) < 0 {
                    swap(i1: current, i2: current - 1)
                }else { // 有序部分已经有序了
                    break
                }
                current -= 1
            }
        }
    }
}

//MARK:  插入排序-优化1（交换改挪动）
class InsertionSort3<T: Comparable>: Sort<T> {

    /*
     * 将交换改为挪动
     * 先记录待插入的元素
     * 头部有序数列中比待插入元素大的, 都向后挪动一个位置
     * 将待插入元素放到合适的位置
     * 比较次数：225 移动次数：204
     */
    override func sortAction() {
        for begin in 1..<dataArray.count {
            var current = begin
            let value = dataArray[current]
            while current > 0 && cmp(e1: value, e2: dataArray[current - 1]) < 0 {  // 注意条件
                dataArray[current] = dataArray[current - 1] // 不交换 往后移动一个位置
                current -= 1
            }
            dataArray[current] = value
        }
    }
}

//MARK:  插入排序-优化2（二分搜索）
class InsertionSort4<T: Comparable>: Sort<T> {

    /*
     * 二分搜索查找索引 只是减少了比较次数 依然要移动 时间复杂度依然是O(n^2)
     * 插入排序 - 平均、最坏时间复杂度O(n^2)、最好时间复杂度O(n)    空间复杂度O(1)
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
                dataArray[i + 1] = dataArray[i]
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
