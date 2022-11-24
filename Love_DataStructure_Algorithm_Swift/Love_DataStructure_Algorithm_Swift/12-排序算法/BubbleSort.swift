//
//  BubbleSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

//MARK: - 冒泡排序
/// 冒泡排序1
/// 平均、最坏复杂度O(n^2)  最好时间复杂度O(n) 空间复杂度O(1)
/// 稳定排序
class BubbleSort1<T: Comparable>: Sort<T> {
    
    /*
     * 1、比较两个相邻的元素。如果第一个比第二个大，就交换他们两个。
     * 2、对每一对相邻元素执行同样的操作，从开始第一对到结尾的最后一对。一趟扫描完毕，最后的元素应该会是最大的数。
     * 3、针对所有的元素重复以上的步骤，除了最后一个。
     * 4、持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较次数：406 交换次数：224 耗时：0.0011131763458251953
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


//MARK: 冒泡排序(外层优化)
/// 冒泡排序2 - 外层优化（如果排序过程中 已经有序 可以提前结束for循环）
class BubbleSort2<T: Comparable>: Sort<T> {
    
    /*
     * 当发现在某一趟排序中没有发生交换，则说明排序已经完成，所以可以在此趟排序后提前结束排序。在每趟排序前设置flag，当其未发生改变时，终止算法；
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较次数：400 交换次数：224 耗时：0.0007848739624023438
     */
    override func sortAction() {
        
        for end in (1...(dataArray.count-1)).reversed() {
            
            var isSorted = true // 1、假定sorted = YES
            
            for begin in 1...end {
                
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                    
                    isSorted = false // 2、更新sorted = NO
                }
            }
            
            if isSorted { break } // 3、提前结束for循环
        }
    }
}

//MARK: 冒泡排序(内层优化)
/// 冒泡排序3 - 内层优化（如果排序过程中 后面部分有序 可以减少for循环范围）
class BubbleSort3<T: Comparable>: Sort<T> {
    
    /*
     *  每趟排序中，最后一次发生交换的位置后面的数据均已有序，所以我们可以记住最后一次交换的位置来减少排序的趟数。
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较次数：394 交换次数：224 耗时：0.000736236572265625
     */
    override func sortAction() {
        
        var sortedIndex = dataArray.count-1 // 1、假定dataArray.count-1后是有序的
        
        for var end in (1...(dataArray.count-1)).reversed() {
             
            if end > sortedIndex {continue}
            
            for begin in 1...end {
                
                if  cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                    
                    sortedIndex = begin // 2、更新sortedIndex = begin
                }
            }
            
            end = sortedIndex // 3、减少for循环范围
        }
    }
}


