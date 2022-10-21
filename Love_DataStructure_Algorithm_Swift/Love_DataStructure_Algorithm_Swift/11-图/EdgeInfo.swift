//
//  EdgeInfo.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/22.
//

import Cocoa

/// 边信息 - 返回给外部使用的
struct EdgeInfo<V: Comparable, E: Comparable> {

    /// 起始点
    var from: V?
    
    /// 终止点
    var to: V?
    
    /// 权重
    var weight: Double?
    
    
    init(from: V?, to: V?, weight: Double?) {
        self.from = from
        self.to = to
        self.weight = weight
    }
    
    func toString() -> String {
        let from = String(describing: from)
        let to = String(describing: to)
        let weight = String(describing: weight)
        return "EdgeInfo [from=\(from), to=\(to), weight=\(weight)]"
    }
}
 
extension EdgeInfo: Comparable & Hashable {
    
    static func < (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW < rhsW
        }
        if lhs.weight == nil && rhs.weight != nil {
            return true
        }
        return false
    }
    
    static func > (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW > rhsW
        }
        if lhs.weight != nil && rhs.weight == nil {
            return true
        }
        return false
    }
    
    static func == (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW == rhsW
        }
        return lhs.weight == nil && rhs.weight == nil
    }
    
    func hash(into hasher: inout Hasher) {
        let from = String(describing: from)
        let to = String(describing: to)
        let weight = String(describing: weight)
        hasher.combine(from + to + weight)
    }
}
