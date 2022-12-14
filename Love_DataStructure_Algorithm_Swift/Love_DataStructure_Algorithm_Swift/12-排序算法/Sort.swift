//
//  Sorted.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/2.
//

import Cocoa

class Sort<T: Comparable> {

    //MARK: - 属性
    /// 存储数组
    var dataArray = [T]()
    /// 比较次数
    fileprivate var cmpCount = 0
    /// 交换次数
    fileprivate var swapCount = 0
    /// 耗时
    fileprivate var time: Double = 0
    
    
    //MARK: - 方法
    /// 排序数组
    final func sorted(by array: [T]) -> [T] {
        if array.count < 2 { return array }
        dataArray = array
        
        let begin = Date().timeIntervalSince1970
        sortAction()
        let end = Date().timeIntervalSince1970
        time = end - begin
        
        
        print("比较次数：\(cmpCount) 交换次数：\(swapCount) 耗时：\(time)")
        
        return dataArray
    }
    
    /// 需要呗子类继承
    func sortAction() {
        fatalError("Must Override")
    }
    
    /// 比较算法
    func compareTo(_ item: Sort) -> Int {
        // 先比较消耗时间
        var result = Int(time - item.time)
        if result != 0 { return result }
        
        // 在比较比较次数
        result = cmpCount - item.cmpCount
        if result != 0 { return result }
        
        // 最后比较交换次数
        return swapCount - item.swapCount
    }
}


//MARK: - 辅助方法
extension Sort {
    /*
     * 根据索引比较
     * 返回值等于0，代表 array[i1] == array[i2]
     * 返回值小于0，代表 array[i1] < array[i2]
     * 返回值大于0，代表 array[i1] > array[i2]
     */
    func cmp(i1: Int, i2: Int) -> Int {
        let v1 = dataArray[i1]
        let v2 = dataArray[i2]
        
        return cmp(e1: v1, e2: v2)
    }
    
    /// 直接比较值
    func cmp(e1: T, e2: T) -> Int {
        cmpCount += 1
        
        if e1 > e2 { return 1 }
        if e1 < e2 { return -1 }
        return 0
    }
    
    func swap(i1: Int, i2: Int) {
        swapCount += 1
        
        let tmp = dataArray[i1]
        dataArray[i1] = dataArray[i2]
        dataArray[i2] = tmp
    }
}


extension Sort {
    /// 数字转化
    func numString(_ number: Int) -> String {
        if number < 10000 { return "\(number)" }
        if number < 100000000 {
            let num = Double(number) / 10000
            return "\(num)万"
        }
        
        let num = Double(number) / 100000000
        return "\(num)亿"
    }
    
    func toString() -> String {
        let timeStr = "耗时：" + (time >= 1 ? "\(time)秒" : "\(time * 1000)毫秒")
        let compareCountStr = "比较：" + numString(cmpCount) + "次"
        let swapCountStr = "交换：" + numString(swapCount) + "次"
        return timeStr + " \n"
            + compareCountStr + "\n"
            + swapCountStr + "\n"
            + "------------------------------------------------------------------"
    }
}
