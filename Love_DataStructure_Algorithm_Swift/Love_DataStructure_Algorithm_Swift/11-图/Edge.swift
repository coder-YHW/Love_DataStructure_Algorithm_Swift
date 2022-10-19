//
//  Edge.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/22.
//

import Cocoa

/// 边
struct Edge<V: Comparable & Hashable, E: Comparable> {
    
    //MARK: - 属性
    /** from - 来的顶点*/
    var from: Vertex<V, E>?
    /** to - 去的顶点*/
    var to: Vertex<V, E>?
    /** weight - 权重*/
    var weight: Double?
    
    
    //MARK: - 构造函数
    init(from: Vertex<V, E>?, to: Vertex<V, E>?) {
        self.from = from
        self.to = to
    }
    
    
    //MARK: - 方法
    /// 边信息
    func edgeInfo() -> EdgeInfo<V, E> {
        return EdgeInfo(from: from?.value, to: to?.value, weight: weight)
    }
    
    /// 哈希值
//    func hashCode() -> Int {
//        let hashCode1 = from?.hashValue
//        let hashCode2 = to?.hashValue
//        return (from?.hashCode() ?? 0) * 31 + (to?.hashCode() ?? 0)
//    }

    func toString() -> String {
        let from = from?.toString() ?? ""
        let to = to?.toString() ?? ""
        let weight = String(describing: weight)
        return "Edge [from=\(from), to=\(to), weight=\(weight)]"
    }
}


extension Edge: Hashable & Comparable {
    
    /// 重写Comparable协议方法
    static func == (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
        return lhs.from == rhs.from && lhs.to == lhs.to
    }
    
    /// 重写Comparable协议方法
    static func < (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW < rhsW
        }
        if lhs.weight == nil && rhs.weight != nil {
            return true
        }
        return false
    }
    
    /// 重写Comparable协议方法
    static func > (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW > rhsW
        }
        if lhs.weight != nil && rhs.weight == nil {
            return true
        }
        return false
    }
    
    /// 重写Hashable协议方法
    func hash(into hasher: inout Hasher) {
        hasher.combine(from)
        hasher.combine(to)
    }
}


// MARK: - 打印
extension Edge : CustomStringConvertible {
    
    var description: String {
        
        return "边：Edge [fromVertex:\(from!.value!) toVertex:\(to!.value!) weight:\(weight ?? 0)])"
    }
}
