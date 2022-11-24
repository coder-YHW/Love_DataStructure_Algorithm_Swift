//
//  QuickSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/26.
//

import Cocoa

/// 快速排序 = 轴点分割 ➕ 轴点排序
/// 快速排序 - 逐渐将每一个元素都转换成轴点元素
/// 时间复杂度O(nlogn)  空间复杂度O(logn)
/// 最坏时间复杂度O(n^2)  全是逆序对的时候性能最差
class QuickSort<T: Comparable>: Sort<T> {

    //MARK: - 快速排序
    override func sortAction() {
        pivotDivide(begin: 0, end: dataArray.count)
    }

    //MARK: 轴点分割
    /**
     * 1、从序列[begin, end)范围内，随机选择一个轴点元素pivot
     * 2、利用pivot将序列分割成2个子序列
     * （将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
     * 3、递归对左右子序列 重复1、2操作，直到只剩下一个元素或者没有元素时，不再排序。
     */
    fileprivate func pivotDivide(begin: Int, end: Int) {
        // 递归基
        if end - begin < 2 { return }
        
        // 1、从序列[begin, end)范围内，随机选择一个轴点元素pivot
        // 2、利用pivot将序列分割成2个子序列
        //（将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
        let pivot = pivotSort(begin: begin, end: end)
        
        // 3、递归对左右子序列 重复1、2操作，直到只剩下一个元素或者没有元素时，不再排序。
        pivotDivide(begin: begin, end: pivot)
        pivotDivide(begin: pivot + 1, end: end)
    }
    
    
    //MARK: 轴点排序
    /**
     * 1、为防止出现完全逆序的数组，在排序之前，随机交换一个数据到第一个位置。
     * 2、随机交换完首元素之后，选择第一个元素作为轴点元素pivot
     * 3、利用pivot将序列分割成2个子序列
     *（将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
     * 4、左右反复扫描 交换元素位置 保持3的性质
     */
    fileprivate func pivotSort(begin: Int, end: Int) -> Int {
        // 1、为防止出现完全逆序的数组，导致快速排序的性能很差。主要是因为每次都是取第一个元素作为标志位。
        // 在排序之前，随机交换一个数据到第一个位置。
        let random = Int.random(in: begin..<end)
        swap(i1: random, i2: begin)
        
        // 2、随机交换完首元素之后，选择第一个元素作为轴点元素pivot
        let pivotVal = dataArray[begin]
        var begin = begin
        var end = end - 1 // [begin, end) 左闭右开区间
        
        // 3、利用pivot将序列分割成2个子序列
        //（将小于pivot的放在轴点左边，大于pivot的放在轴点右边，等于pivot的放轴左右都可以）
        // 4、左右反复扫描 交换元素位置 保持3的性质
        while begin < end {
            
            // 4.1、从右往左扫描 <-
            while begin < end {
                if cmp(e1: pivotVal, e2: dataArray[end]) < 0 { // 轴点元素 < 右边元素 ： end--
                    end -= 1   // 扫描方向不变 收缩右边界
                } else {       // 轴点元素 >= 右边元素 : 调换位置
                    dataArray[begin] = dataArray[end]
                    begin += 1 // 扫描方向改变 收缩左边界
                    break
                }
            }
            
            // 4.2、从左往右扫描 ->
            while begin < end {
                if cmp(e1: pivotVal, e2: dataArray[begin]) > 0 { // 轴点元素 > 左边元素 ： begin++
                    begin += 1  // 扫描方向部变 收缩左边界
                } else {        // 轴点元素 <= 左边元素 : 调换位置
                    dataArray[end] = dataArray[begin]
                    end -= 1    // 扫描方向改变 收缩右边界
                    break
                }
            }
        }
        
        // 4.3、将轴点元素放入最终位置
        dataArray[begin] = pivotVal
        // 返回轴点元素最终位置
        return begin // begin = end
    }
}
