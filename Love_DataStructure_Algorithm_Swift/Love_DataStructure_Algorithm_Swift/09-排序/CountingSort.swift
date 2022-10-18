//
//  CountingSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/28.
//

import Cocoa

/// 计数排序 - 对一定范围内的整数进行排序
/// 空间换时间
/// 时间复杂度 空间复杂度都是 O(n+k)  k是整数的取值范围
/// 稳定排序
class CountingSort<T: Comparable>: Sort<T> {
    
    override func sortAction() {
        
        guard let intArray = dataArray as? [Int] else { return }
        
        // 1、最大值、最小值
        var min = intArray[0]
        var max = intArray[0]
        for val in intArray {
            if val > max {
                max = val
            }
            if val < min {
                min = val
            }
        }
        
        // 2、开辟内存空间存储次数 ：max - min + 1
        var counts = Array(repeating: 0, count: max - min + 1)
        // 2.1、统计每个整数出现的次数
        for val in intArray {
            var count = counts[val - min]
            count += 1
            counts[val - min] = count
        }
        
        // 3、累加次数
        for i in 1..<counts.count {
            var count = counts[i]
            count += counts[i - 1]
            counts[i] = count
        }
        
        // 4、从后往前遍历元素, 将val放到新有序数组newArray中的合适位置 （从右往左 <- 稳定性）
        var newArray = Array(repeating: 0, count: intArray.count)
        
        for i in (0..<intArray.count - 1).reversed() {
            let val = intArray[i]; // 反向遍历 取出val
            var count = counts[val - min] // val对应次数
            count -= 1 // 索引--
            counts[val - min] = count; // 更新counts
            newArray[count] = intArray[i] // 插入newArray对应位置
        }
        
        // 5、将有序数组newArray复制到array
        for i in 0..<newArray.count {
            if let item = newArray[i] as? T {
                dataArray[i] = item
            }
        }
    }
}
