//
//  BucketSort.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/4.
//

import Cocoa


class BucketSort {
    
    /// 存储数组
    var dataArray = [Double]()
    
    /// 比较数组
    func sorted(by array: [Double]) -> [Double] {
        if array.count < 2 { return array }
        dataArray = array
        sortAction()
        return dataArray
    }

    fileprivate func sortAction() {
        var buckets = Array<Array<Double>?>(repeating: nil, count: dataArray.count)
        for i in 0..<dataArray.count {
            let value = dataArray[i]
            let bucketIndex = Int(value * Double(dataArray.count))
            var bucket = buckets[bucketIndex]
            if bucket == nil {
                bucket = [dataArray[i]]
            } else {
                bucket?.append(dataArray[i])
            }
            buckets[bucketIndex] = bucket
        }
        
        var index = 0
        for i in 0..<buckets.count {
            guard let bucket = buckets[i] else { continue }
            let quick = QuickSort<Double>()
            let arr = quick.sorted(by: bucket)
            for val in arr {
                dataArray[index] = val
                index += 1
            }
        }
    }
}
