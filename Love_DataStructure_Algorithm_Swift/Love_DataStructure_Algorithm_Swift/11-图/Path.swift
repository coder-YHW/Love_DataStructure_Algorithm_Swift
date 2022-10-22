//
//  Path.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/22.
//

import Cocoa

/// 路径
class Path<V: Comparable & Hashable, E: Comparable> {
    
    //MARK: - 属性
    /// 权重
    var weight: Double = 0
    
    /// 路径上所有的边, 存储的有顺序的边
    var edgeInfos = [Edge<V, E>]()
    
}


//MARK: - Comparable
extension Path: Comparable {
    static func < (lhs: Path<V, E>, rhs: Path<V, E>) -> Bool {
        return lhs.weight < rhs.weight
    }
    
    static func > (lhs: Path<V, E>, rhs: Path<V, E>) -> Bool {
        return lhs.weight > rhs.weight
    }
    
    static func == (lhs: Path<V, E>, rhs: Path<V, E>) -> Bool {
        return lhs.weight == rhs.weight
    }
}


// MARK: - 打印
extension Path : CustomStringConvertible {
    
    var description: String {
        
        var text = "weight:\(weight) 路径：["
        
        for edge in edgeInfos {
            text += "\(edge.from!) -> \(edge.to!) weight: \(edge.weight!), "
        }
        
        text += "]"
        
        return text
    }
}
