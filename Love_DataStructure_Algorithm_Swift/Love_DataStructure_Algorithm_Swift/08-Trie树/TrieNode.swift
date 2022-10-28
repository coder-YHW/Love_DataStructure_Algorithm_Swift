//
//  TrieNode.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

class TrieNode<E: Comparable>: Comparable {
    
    static func == (lhs: TrieNode<E>, rhs: TrieNode<E>) -> Bool {
        return lhs.character == rhs.character
    }
    
    static func < (lhs: TrieNode<E>, rhs: TrieNode<E>) -> Bool {
        return lhs.character?.asciiValue ?? 0 < rhs.character?.asciiValue ?? 0
    }
    

    //MARK: - 属性
    public var parent: TrieNode?
    public var children: HashMap<Character, TrieNode<E>>?
    public var character: Character? //  节点对应的字符
    public var isWord: Bool // 是否为单词的结尾（是否为一个完整的单词）
    public var value: E? // isWord为yes时 单词对应的value
    
    //MARK: - 构造函数
    init(parent: TrieNode? = nil, children: HashMap<Character, TrieNode<E>>? = nil, character: Character? = nil, isWord: Bool = false, value: E? = nil) {
        self.parent = parent
        self.children = children
        self.character = character
        self.isWord = isWord
        self.value = value
    }
    
}
