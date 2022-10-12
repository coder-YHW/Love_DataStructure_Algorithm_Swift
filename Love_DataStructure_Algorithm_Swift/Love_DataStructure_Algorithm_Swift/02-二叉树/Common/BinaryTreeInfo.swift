//
//  BinaryTreeInfo.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/19.
//

import Cocoa


protocol BinaryTreeProtocol  {
    /// 根节点
    func getRoot() -> Any?
    
    /// 左节点
    func left(node: Any?) -> Any?
    
    /// 右节点
    func right(node: Any?) -> Any?
    
    /// 转字符串
    func string(node: Any?) -> String
}
