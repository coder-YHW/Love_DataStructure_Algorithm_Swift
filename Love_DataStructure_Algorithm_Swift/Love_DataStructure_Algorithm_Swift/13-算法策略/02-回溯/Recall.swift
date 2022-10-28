//
//  RecallFirst.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/28.
//

import Cocoa

/// 回溯 = 枚举 ➕ 递归➕ 剪枝
//MARK: - RecallFirst 四皇后(2) — 八皇后(92) — n皇后问题
/// 四皇后(2) — 八皇后(92) — n皇后问题
class RecallFirst {

    /// 皇后所在的行列, 索引为行号 值为列号
    var queens = [Int]() // 二维数组思想
    /// 一共有多少中摆法
    var ways = 0
    
    /// n皇后摆法
    func quaceQueens(_ number: Int) {
        if number < 1 { return }
        queens = Array(repeating: Const.notFound, count: number)
        place(row: 0)
        print("\(number)皇后共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆放
    fileprivate func place(row: Int) {
        // 摆放完成的方案有多少种
        if row == queens.count { // 摆放完成
            ways += 1
            showArrannge()
            return
        }
        
        /// 回溯思想 - 遍历所有方案
        /// 从第row行 第0列开始尝试摆放
        /// 从第row行 第1列开始尝试摆放
        /// 从第row行 第2列开始尝试摆放
        /// ....
        /// 从第row行 第n列开始尝试摆放
        for i in 0..<queens.count {
            if isVaild(row: row, col: i) {
                queens[row] = i     // 可以摆放 就放在第row行 第i列
                place(row: row + 1) // 继续递归 - 摆放第row+1行
                /// 摆放成功：继续下次for循环 相当于回溯 尝试其他方案
            }else {
                /// 第row行 第i列 此方案行不通 - 结束此次摆放
                /// 摆放失败：继续下次for循环 相当于回溯 尝试其他方案
                continue
            }
        }
    }
    
    /// 剪枝思想：判断第row行第col列是否可以摆放
    fileprivate func isVaild(row: Int, col: Int) -> Bool {
        
        for i in 0..<row {
            // 1、第row列有没有皇后
            // 2、在某一行有没有皇后不用考虑 都是在新行摆放
            if queens[i] == col { // 第i行的皇后在哪一列
                return false
            }
            
            // 3、对角线上有没有皇后 (8x8 对角线斜率为1 也就是说 高度差/宽度差 = 1)
            if (row - i) == abs(col - queens[i]) {
                return false
            }
        }
        
        return true
    }
    
    /// 打印n皇后排列
    fileprivate func showArrannge() {
        for row in 0..<queens.count {
            for col in 0..<queens.count {
                if queens[row] == col {
                    print("1 ", terminator: "")
                } else {
                    print("0 ", terminator: "")
                }
            }
            print("")
        }
        print("-----------------")
    }
}


//MARK: - RecallSecord 八皇后问题优化, 成员变量
/// 八皇后问题优化, 成员变量
class RecallSecord {

    /// 皇后所在的行列, 索引为行, 元素为列
    var queens = [Int]()
    /// 某一列是否有皇后
    var cols = [Bool]()
    /// 左对角线上是否有皇后(左上角-->右下角)
    var leftTops = [Bool]()
    /// 右对角线上是否有皇后(右上角-->左下角)
    var rightTops = [Bool]()
    /// 一共有多少中摆法
    var ways = 0
    
    /// n皇后摆法
    func quaceQueens(_ number: Int) {
        if number < 1 { return }
        queens = Array(repeating: Const.notFound, count: number)
        cols = Array(repeating: false, count: number)
        leftTops = Array(repeating: false, count: (number << 1) - 1)
        rightTops = Array(repeating: false, count: leftTops.count)
        place(row: 0)
        print("\(number)皇后共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆放
    fileprivate func place(row: Int) {
        if row == queens.count {
            ways += 1
            showArrannge()
            return
        }
        
        for col in 0..<cols.count {
            // 1.1、列存在皇后
            if cols[col] { continue }
            // leftTops索引公式：leftIndex = row - col + cols.count - 1
            // 1.2、leftTops对角线存在皇后
            let leftIndex = row - col + cols.count - 1
            if leftTops[leftIndex] { continue }
            // rightTops索引公式：rightIndex = row + col
            // 1.3、rightTops对角线存在皇后
            let rightIndex = row + col
            if rightTops[rightIndex] { continue }
             
            // 2、可以摆放 就放在第row行 第col列
            queens[row] = col
            cols[col] = true
            leftTops[leftIndex] = true
            rightTops[rightIndex] = true
            // 递归调用 继续往下走
            place(row: row + 1)
            
            /// 函数调用栈：递归调用完成 才会来到这里
            /// 递归摆放失败 - 回溯, 重置状态
            cols[col] = false
            leftTops[leftIndex] = false
            rightTops[rightIndex] = false
        }
    }
    
    /// 打印n皇后排列
    fileprivate func showArrannge() {
        for row in 0..<queens.count {
            for col in 0..<queens.count {
                if queens[row] == col {
                    print("1 ", terminator: "")
                } else {
                    print("0 ", terminator: "")
                }
            }
            print("")
        }
        print("-----------------")
    }
}


//MARK: - RecallThird  八皇后问题, 位运算处理
/// 只是用于八皇后问题, 位运算处理
class RecallThird {

    /// 皇后所在的行列, 索引为行, 元素为列
    var queens = [Int]()
    /// 某一列是否有皇后
    var cols = 0x00000000
    /// 左对角线上是否有皇后(左上角-->右下角)
    var leftTops = 0x000000000000000
    /// 右对角线上是否有皇后(右上角-->左下角)
    var rightTops = 0x000000000000000
    /// 一共有多少中摆法
    var ways = 0
    
    /// n皇后摆法
    func quaceQueens() {
        queens = Array(repeating: Const.notFound, count: 8)
        place(row: 0)
        print("8皇后共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆放
    fileprivate func place(row: Int) {
        if row == queens.count {
            ways += 1
            showArrannge()
            return
        }
        
        for col in 0..<8 {
            let cv = 1 << col
            if cols & cv != 0 { continue }
            
            let lv = 1 << (row - col + 7)
            if leftTops & lv != 0 { continue }
            
            let rv = 1 << (row + col)
            if rightTops & rv != 0 { continue }
            
            queens[row] = col
            cols |= cv
            leftTops |= lv
            rightTops |= rv
            place(row: row + 1)
            /// 回溯, 重置状态
            cols &= ~cv
            leftTops &= ~lv
            rightTops &= ~rv
        }
    }
    
    /// 打印n皇后排列
    fileprivate func showArrannge() {
        for row in 0..<queens.count {
            for col in 0..<queens.count {
                if queens[row] == col {
                    print("1 ", terminator: "")
                } else {
                    print("0 ", terminator: "")
                }
            }
            print("")
        }
        print("-----------------")
    }
}


