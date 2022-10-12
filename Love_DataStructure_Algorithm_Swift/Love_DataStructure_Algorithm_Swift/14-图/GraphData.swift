//
//  GraphData.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/29.
//

import Cocoa

struct GraphData {
    

    static let BFS_01 = [
            ["A", "B"], ["A", "F"],
            ["B", "C"], ["B", "I"], ["B", "G"],
            ["C", "I"], ["C", "D"],
            ["D", "I"], ["D", "G"], ["D", "E"], ["D", "H"],
            ["E", "H"], ["E", "F"],
            ["F", "G"],
            ["G", "H"]
    ]
    
    static let BFS_02 = [
            [0, 1], [0, 4],
            [1, 2],
            [2, 0], [2, 4], [2, 5],
            [3, 1],
            [4, 6], [4, 7],
            [5, 3], [5, 7],
            [6, 2], [6, 7]
    ]
    
    static let BFS_03 = [
            [0, 2], [0, 3],
            [1, 2], [1, 3], [1, 6],
            [2, 4],
            [3, 7],
            [4, 6],
            [5, 6],
            [6, 7]
    ]
    
    static let BFS_04 = [
            [1, 2], [1, 3], [1, 5],
            [2, 0],
            [3, 5],
            [5, 6], [5, 7],
            [6, 2],
            [7, 6]
    ]
    
    static let DFS_01 = [
            [0, 1],
            [1, 3], [1, 5], [1, 6], [1, 2],
            [2, 4],
            [3, 7]
    ]
    
    static let DFS_02 = [
            ["a", "b"], ["a", "e"],
            ["b", "e"],
            ["c", "b"],
            ["d", "a"],
            ["e", "c"], ["e", "f"],
            ["f", "c"]
    ]
    
    
    /*
      <----------------------         
     7 --------> 6->4       |
     ^           ^          |
     |           |          |
     3-->1-->0-->2-->5------
     |               ^
     |               |
     ----------------
     */
    static let TOPO = [
            [0, 2],
            [1, 0],
            [2, 5], [2, 6],
            [3, 1], [3, 5], [3, 7],
            [5, 7],
            [6, 4],
            [7, 6]
    ]
    
    static let NO_WEIGHT2 = [
            [0, 3],
            [1, 3], [1, 6],
            [2, 1],
            [3, 5],
            [6, 2], [6, 5],
            [4, 7]
    ]
    
    static let NO_WEIGHT3 = [
            [0, 1], [0, 2],
            [1, 2], [1, 5],
            [2, 4], [2, 5],
            [5, 6], [7, 6],
            [3]
    ]
    
    /// 有权值
    static let MST_01 = [
            [0, 2, 2], [0, 4, 7],
            [1, 2, 3], [1, 5, 1], [1, 6, 7],
            [2, 4, 4], [2, 5, 3], [2, 6, 6],
            [3, 7, 9],
            [4, 6, 8],
            [5, 6, 4], [5, 7, 5]
    ]
    
    static let MST_02 = [
            ["A", "B", 17], ["A", "F", 1], ["A", "E", 16],
            ["B", "C", 6], ["B", "D", 5], ["B", "F", 11],
            ["C", "D", 10],
            ["D", "E", 4], ["D", "F", 14],
            ["E", "F", 33]
    ]
    
    static let WEIGHT3 = [
            ["广州", "佛山", 100], ["广州", "珠海", 200], ["广州", "肇庆", 200],
            ["佛山", "珠海", 50], ["佛山", "深圳", 150],
            ["肇庆", "珠海", 100], ["肇庆", "南宁", 150],
            ["珠海", "南宁", 350], ["珠海", "深圳", 100],
            ["南宁", "香港", 500], ["南宁", "深圳", 400],
            ["深圳", "香港", 150]
    ]
    
    static let SP = [
            ["A", "B", 10], ["A", "D", 30], ["A", "E", 100],
            ["B", "C", 50],
            ["C", "E", 10],
            ["D", "C", 20], ["D", "E", 60]
    ]
    
    static let BF_SP = [
            ["A", "B", 10], ["A", "E", 8],
            ["B", "C", 8], ["B", "E", -5],
            ["D", "C", 2], ["D", "F", 6],
            ["E", "D", 7], ["E", "F", 3]
    ]
    
    static let WEIGHT5 = [
            [0, 14, 1], [0, 4, 8],
            [1, 2, 9],
            [2, 3, 6], [2, 5, 9],
            [3, 17, 1], [3, 10, 4],
            [4, 5, 2], [4, 8, 2],
            [5, 6, 6], [5, 8, 1], [5, 9, 4],
            [6, 9, 8],
            [7, 11, 4],
            [8, 9, 1], [8, 11, 2], [8, 12, 7],
            [9, 10, 7], [9, 13, 4],
            [10, 13, 2],
            [11, 12, 7], [11, 15, 4],
            [12, 13, 2], [12, 16, 2],
            [13, 16, 7],
            [15, 16, 7], [15, 17, 7],
            [16, 17, 2]
    ]
    
    static let NEGATIVE_WEIGHT1 = [
            ["A", "B", -1], ["A", "C", 4],
            ["B", "C", 3], ["B", "D", 2], ["B", "E", 2],
            ["D", "B", 1], ["D", "C", 5],
            ["E", "D", -3]
    ]
    
    /**
     * 有负权环
     */
    static let NEGATIVE_WEIGHT2 = [
            [0, 1, 1],
            [1, 2, 7],
            [1, 0, -2]
    ]
}
