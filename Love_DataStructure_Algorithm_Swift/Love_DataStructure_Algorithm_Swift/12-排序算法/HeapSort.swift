//
//  HeapSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

/// 堆排序 - 选择排序进阶版
/// 堆排序 = 原地建堆 ➕ 对堆排序 ➕ 下滤操作
/// 堆排序 - 平均、最坏、最好复杂度O(nlogn)    空间复杂度O(1)
/// 稳定排序
class HeapSort<T: Comparable>: Sort<T> {
    
    /// 堆元素个数
    fileprivate var heapCount = 0
    
    //MARK: - 堆排序
    /// 通过堆排序
    override func sortAction() {
        
        heapCount = dataArray.count
        
        //MARK:  1、原地建堆
        // 1.对序列进行原地建堆（构建大顶堆）
        let lastIndex = heapCount >> 1 - 1 // 对所有非叶子结点 进行自下而上的下滤
        for i in (0...lastIndex).reversed() {  // 0 <= i <= (heapCount/2 - 1)
            siftDown(i)
        }
        
        //MARK: 2、对堆排序（交换堆顶元素与末尾元素）
        // 2.调整堆结构（交换堆顶元素与末尾元素-排序）
        while heapCount > 1 { // heapCount > 1
            // 2.1、交换堆顶元素和尾部元素
            swap(i1: 0, i2: heapCount - 1)
            // 2.2、堆的元素数量减1
            heapCount -= 1
            // 2.3、对0位置进行一次siftDown操作
            siftDown(0)
        }
    }
    
    //MARK:  3、下滤操作
    /// 下滤
    fileprivate func siftDown(_ index: Int) {
        
        let value = dataArray[index]
        let half = heapCount >> 1
        var currentIndex = index
        
        // 1、非叶子结点（能够下滤的前提是非叶子结点）
        while currentIndex < half {
            
            // 2、找出当前节点较大的子节点
            // 2.1、左子节点索引
            var childIndex = currentIndex << 1 + 1
            var childVal = dataArray[childIndex]
        
            // 2.2、右子节点索引
            let rightIndex = childIndex + 1
            
            // 2.3、如果存在右子节点 && 右子节点 > 左子节点 => 右子节点替换左子节点
            if rightIndex < heapCount && cmp(e1: dataArray[rightIndex], e2: childVal) > 0 {
                childIndex = rightIndex
                childVal = dataArray[rightIndex]
            }
            
            // 3.1、如果当节点比较大的子节点大，直接返回
            if cmp(e1: childVal, e2: value) <= 0 { break }
                
            // 3.2、如果当节点比较大的子节点小，交换当前节点与这个较大的子节点
            dataArray[currentIndex] = childVal
            // 3.3、重复上述操作
            currentIndex = childIndex
        }
        // 4、将node的值赋值到其索引位置
        dataArray[currentIndex] = value
    }
}
