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
    
}


//MARK: - Hashable & Comparable
extension Vertex: Hashable & Comparable {
    
    /// 1、重写Equatable协议方法
    static func == (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
        return lhs.value == rhs.value
    }
    
    /// 2、重写Comparable协议方法
    static func < (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
        return false
    }
    
    /// 3、重写Hashable协议方法
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}


// MARK: - 打印
extension Vertex : CustomStringConvertible {
    
    var description: String {
        
        return "Vertex：\(value!)"
    }
}
