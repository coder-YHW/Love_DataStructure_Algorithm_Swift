//
//  Greedy.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/11/4.
//

import Cocoa

/// 贪心
struct Greedy {
    
    
    //MARK: - 最优装载问题
    /**
     * 最优装载问题
     * 船的载重量为W, 每件古董的重量为Wi, 尽可能多的装载古董
     */
    static func reloadWeight(_ weights: [Double], maxWeight: Double) -> [Double] {
        let newWeights = weights.sorted(by: <)
        
        var weight = 0.0
        var arr = [Double]()
        for i in 0..<newWeights.count {
            weight += newWeights[i]
            if weight < maxWeight {
                arr.append(newWeights[i])
            } else {
                break
            }
        }
        
        return arr
    }
    

    //MARK: - 零钱兑换问题
    /**
     * 零钱兑换问题
     * 假设有25分, 10分, 5分, 1分的硬币, 给客户41分的零钱, 让硬币个数最少
     */
    static func changeMoney1(_ coins: [Int], money: Int) -> [Int] {
        let coinArr = coins.sorted(by: >)
        var array = [Int]()
        var max = money
        var index = 0
        
        while index < coinArr.count {
            while max >= coinArr[index] {
                max -= coinArr[index]
                array.append(coinArr[index])
            }
            index += 1
        }
        
        return array
    }
}
