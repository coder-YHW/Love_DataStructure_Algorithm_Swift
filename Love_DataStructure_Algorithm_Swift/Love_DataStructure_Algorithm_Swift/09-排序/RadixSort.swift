//
//  RadixSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/14.
//

import Cocoa


/// 基数排序 - 擅长对整数（尤其是非负整数）进行排序
/// 依次对十位数、百位数、万位数.... 进行排序 （从低位到高位）
/// /// 空间换时间
/// 时间复杂度 空间复杂度都是 O(d*(n+k)) d是最大整数位数 k是进制
/// 稳定排序
class RadixSort<T: Comparable>: Sort<T> {
    

    override func sortAction() {
        // 1、找出最大值
        var max = dataArray[0]
        for item in dataArray {
            if cmp(e1: max, e2: item) < 0 {
                max = item
            }
        }
        
        // 2、依次对十位数、百位数、万位数.... 进行排序 （从低位到高位）
        /// 个位数：dataArray[i] / 1 % 10
        /// 十位数：dataArray[i] / 10 % 10
        /// 百位数：dataArray[i] / 100 % 10
        /// 千位数：dataArray[i] / 1000 % 10
        /// 。。。
        
        var divider = 1
        let maxInt = max as? Int ?? 0
        while divider <= maxInt {
//            insertSort(divider)
            insertSort1(divider)
            divider *= 10
        }
    }
    
    
    /// 计数排序 -  比较次数：29 交换次数：0
    fileprivate func insertSort(_ divider: Int) {
        // 1、最大值、最小值
        // 0～9
        
        // 2、开辟内存空间存储次数 ：max - min + 1
        var counts = Array(repeating: 0, count: 10)
        // 2.1、统计每个整数出现的次数
        for val in self.dataArray {
            let objVal = (val as! Int) / divider % 10
            
            var count = counts[objVal]
            count += 1
            counts[objVal] = count
        }
        
        // 3、累加次数
        for i in 1..<counts.count {
            var count = counts[i]
            count += counts[i - 1]
            counts[i] = count
        }
        
        // 4、从后往前遍历元素, 将val放到新有序数组newArray中的合适位置 （从右往左 <- 稳定性）
        var newArray = Array(repeating: 0, count: self.dataArray.count)
        
        for i in (0..<self.dataArray.count - 1).reversed() {
            let val = (self.dataArray[i] as! Int) / divider % 10; // 反向遍历 取出val
            var count = counts[val] // val对应次数
            count -= 1 // 索引--
            counts[val] = count; // 更新counts
            newArray[count] = self.dataArray[i] as! Int // 插入newArray对应位置
        }
        
        // 5、将有序数组newArray复制到array
        for i in 0..<newArray.count {
            if let item = newArray[i] as? T {
                dataArray[i] = item
            }
        }
        
    }
    
    
    /// 插入排序 - 比较次数：29 交换次数：412
    fileprivate func insertSort1(_ divider: Int) {
        for i in 1..<dataArray.count {
            var current = i
            while current > 0 {
                let e1 = (dataArray[current] as? Int ?? 0) / divider % 10
                let e2 = (dataArray[current - 1] as? Int ?? 0) / divider % 10
                if e1 < e2 {
                    swap(i1: current, i2: current - 1)
                }
                current -= 1
            }
        }
    }
}
