//
//  Trie.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

/// 前缀树、字典树、单词查找树 （多叉树）
/// 时间复杂度低   空间复杂度高 （有待优化）
class Trie<E: Comparable> {

    //MARK: - 属性
    fileprivate var count = 0
    fileprivate var root: TrieNode<E>?
    
    //MARK: - 构造函数
    init(count: Int = 0, root: TrieNode<E>? = nil) {
        self.count = count
        self.root = root
    }
    
    
    //MARK: - 方法
    /**元素数量**/
    func size() -> Int {
        return count
    }
    
    /**元素是否为空*/
    func isEmpty() -> Bool {
        return count == 0
    }

    /**清空*/
    func clear() {
        count = 0
        root = nil
    }

    //MARK: 查找
    /// 根据字符串查找node
    func nodeOfKey(key: String?) -> TrieNode<E>? {
        
        guard let key = key, key.count != 0 else {
            return nil
        }

        var node = root
        for c in key {
            
            if node == nil || node?.children == nil {
                return nil
            }
            node = node?.children?.get(key: c)
        }
        
        return node
    }
    
    /// 是否包含前缀prefix
    func starsWith(prefix: String?) -> Bool {
        return nodeOfKey(key: prefix) != nil
    }
    
    /// 是否包含字符串key
    func contains(key: String?) -> Bool {
        
        if let node = nodeOfKey(key: key) {
            return node.isWord
        }else {
            return false
        }
    }
    
    ///查找字符串对应value
    func get(key: String) -> E? {
        if let node = nodeOfKey(key: key) {
            return node.value
        }else {
            return nil
        }
    }
    
    //MARK: - 添加删除
    /// 添加一个字符串
    func add(_ key: String?, val: E?) -> E? {
        
        guard let key = key, key.count != 0 else {
            return nil
        }
        
        // 1、创建根节点
        if root == nil {
            root = TrieNode()
        }
        
        // 2、遍历字符
        var node = root
        for c in key {
            
            // 2.1、根据字符获取子节点
            var childNode = node?.children == nil ? nil : node?.children?.get(key: c)
            // 2.2、子节点为空
            if childNode == nil {
                node?.children = node?.children == nil ? HashMap() : node?.children
                childNode = TrieNode(parent: node, character: c)
                node?.children?.put(key: c, val: childNode)
            }
            
            // 2.3、子节点不为空 - 根据字符继续往下查找
            node = childNode
        }
        
        
        // 3、如果已经存在这个单词 - 覆盖
        if node!.isWord {
            
            let oldValue = node?.value
            node?.value = val
            return oldValue
            
        }else {
        // 4、新建一个单词
            node?.isWord = true
            node?.value = val
            
            // 5、索引count += 1
            count += 1
            
            return nil
        }
    }
 
    /// 删除一个字符串
    func remove(_ key: String?) -> E? {
        
        // 1、找到最后一个节点
        guard let node = nodeOfKey(key: key) else {
            return nil
        }
        
        // 2、如果不是单词结尾,不用做任何处理
        if node.isWord == false { return nil } // 这个字符串不存在
        
        // 3、索引count -= 1
        count -= 1;

        let oldValue = node.value
        
        
        // 4、node如果还有子节点 只需要改变word为false value为nil
        if node.children != nil && !node.children!.isEmpty() {
            node.isWord = false
            node.value = nil
            return oldValue
        }
        
        // 5、如果没有子节点 找到node的父节点 删除父节点字符对应的这个node
        var parent = node.parent
        while parent != nil { // 5.1、父节点不为空
            
            parent?.children?.remove(key: node.character!) // 5.2、删除父节点字符对应的这个node
            
            if parent!.isWord || !parent!.children!.isEmpty() {
                break
            }
            
            parent = parent?.parent
        }
        
        return oldValue
    }
}


extension Trie {
    
    fileprivate func keyCheck(_ key: String?) -> Bool {
        
        if let k = key, k.count != 0 {
            return true
        }else {
            print("key must not be empty")
            return false
        }
    }
}
