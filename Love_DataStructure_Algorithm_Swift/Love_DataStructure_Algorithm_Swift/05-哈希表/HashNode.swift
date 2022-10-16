//
//  HashNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/15.
//

import Cocoa


class HashNode<K: Hashable, V: Comparable>: Comparable {
    
    //MARK: - 属性
    public var key: K?
    public var val: V?
    public var isRed = true // 红黑颜色
    public var hashCode = 0 // key -> hashCode

    public var parent: HashNode?
    public var left: HashNode?
    public var right: HashNode?
    
    
    //MARK: - 构造函数
    init(_ key: K?, _ val: V?, parent: HashNode? = nil) {
        self.key = key
        self.val = val
        self.parent = parent
        self.isRed = true
        self.hashCode = getHashCodeFromKey(key: key) // 保存key的hashCode 缓存起来 避免多次计算;
    }
    
    /// 把key哈希化成hashCode
    fileprivate func getHashCodeFromKey(key: K?) -> Int {

        guard let key else {
            return 0
        }
        
        var hashCode = key.hashValue
        hashCode = hashCode ^ (hashCode >> 32)
        return hashCode
    }

    //MARK: - Comparable协议
    static func < (lhs: HashNode, rhs: HashNode) -> Bool {
        let lElement = lhs.val
        let rElement = rhs.val

        if let lhsVal = lElement, let rhsVal = rElement {
            return lhsVal < rhsVal
        }
        return false
    }
    
    static func > (lhs: HashNode, rhs: HashNode) -> Bool {
        let lElement = lhs.val
        let rElement = rhs.val

        if let lhsVal = lElement, let rhsVal = rElement {
            return lhsVal > rhsVal
        }
        return false
    }

    static func == (lhs: HashNode, rhs: HashNode) -> Bool {
        return lhs.val == rhs.val
    }

}


//MARK: - 辅助函数
extension HashNode {
    
    /// 是否是叶子节点
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
    
    /// 有两个节点
    func hasTwoChildren() -> Bool {
        return left != nil && right != nil
    }
    
    /// 当前节点是否是左节点
    func isLeftChild() -> Bool {
        return parent != nil && parent?.left == self
    }
    
    /// 当前节点是否是右节点
    func isRightChild() -> Bool {
        return parent != nil && parent?.right == self
    }
    
    /// 获取叔父节点
    func sibling() -> HashNode? {
        if isLeftChild() {
            return parent?.right
        }
        if isRightChild() {
            return parent?.left
        }
        return nil
    }
}


// MARK: - 打印
extension HashNode {
    
    func string() -> String {
        let v = val == nil ? "nil" : String(describing: val)
        return """
            {"\(1)": "\(v)"
        """
    }
}
