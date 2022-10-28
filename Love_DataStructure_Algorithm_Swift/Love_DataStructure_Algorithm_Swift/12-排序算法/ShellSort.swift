//
//  ShellSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/26.
//

import Cocoa

/// 希尔排序
class ShellSort<T: Comparable>: Sort<T> {

    override func sortAction() {
        // 1、创建步长序列
//        let stepSequence = shellStepSequence()
        let stepSequence = sedgewickStepSequence()
        
        // 2、分成step列进行排序 对每一列进行插入排序
        stepSequence.forEach({ stepSort($0) })
    }
    
    
    /// 2、分成step列进行排序 -对每一列进行插入排序  索引映射：index = col  + row*step
    fileprivate func stepSort(_ step: Int) {
        
        for col in 0..<step { // 对每列row中元素进行插入排序
            
            // 3、插入排序1 = step + col
            var begin = step + col
            while begin < dataArray.count { // 插入排序
                
                var current = begin
                while current > col, cmp(i1: current, i2: current - step) < 0 {
                    swap(i1: current, i2: current - step)
                    current -= step // 相当于current -= 1
                }
                
                // 4、下一个
                begin += step // 相当于begin += 1
            }
        }
    }

    
    /// 3、希尔本人提出的步长序列（ n / 2^k ）
    fileprivate func shellStepSequence() -> [Int] {
        
        var stepSequence = [Int]()
        var step = dataArray.count >> 1
        
        while step > 0 { // 不断的除以2
            stepSequence.append(step)
            step = step >> 1
        }
        
        return stepSequence
    }
    
    
    /// 目前最好的步长序列 - sedgewick 数学公式
    fileprivate func sedgewickStepSequence() -> [Int] {
        
        var stepSequence = [Int]()
        var k: Float = 0
        var step = 0
        
        while step < dataArray.count {
            if Int(k) % 2 == 0 {
                let pow = Int(powf(2, k / 2))
                step = 9 * pow * (pow - 1)  + 1
            } else {
                let pow1 = Int(powf(2, k))
                let pow2 = Int(powf(2, (k + 1) / 2))
                step = 8 * pow1 - 6 * pow2 + 1
            }
            stepSequence.insert(step, at: 0)
            k += 1
        }
        
        return stepSequence
    }
}
