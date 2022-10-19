//
//  Vertex.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/22.
//

import Cocoa

struct Vertex<V: Comparable & Hashable, E: Comparable> {

    //MARK: - 属性
    /** value*/
    var value: V?
    /** inEdges - 入度的边s - 多条无序*/
    var inEdges = HashSet<Edge<V, E>>()
    /** outEdges - 出度的边s - 多条无序*/
    var outEdges = HashSet<Edge<V, E>>()
    
    
    //MARK: - 构造函数
    init(val: V) {
        self.value = val
    }
    
    
    //MARK: - 方法
    /// 哈希值
    func hashCode() -> Int {
        if let val = value {
            return val.hashValue
        }
        return 0
    }
    
    func toString() -> String {
        if let val = value {
            return "Vertex:\(val)"
        }
        return "nil"
    }
    
    func inEdgesString() -> String {
        if inEdges.allElements().isEmpty {
            return "[]"
        }
        var string = ""
        inEdges.allElements().forEach { edge in
            string += edge.toString()
            string += "\n"
        }
        return string
    }
    
    func outEdgesString() -> String {
        if outEdges.allElements().isEmpty {
            return "[]"
        }
        var string = ""
        outEdges.allElements().forEach { edge in
            string += edge.toString()
            string += "\n"
        }
        return string
    }
}

extension Vertex: Hashable & Comparable {
    static func < (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
        return false
    }
    
    static func == (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        let text = String(describing: value)
        hasher.combine(text)
    }
}


// MARK: - 打印
extension Vertex : CustomStringConvertible {
    
    var description: String {
        
        return "Vertex：\(value!)"
    }
}
