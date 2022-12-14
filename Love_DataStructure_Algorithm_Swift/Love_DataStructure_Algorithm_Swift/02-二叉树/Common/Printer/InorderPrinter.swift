//
//  InorderPrinter.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/19.
//

import Cocoa


/*
      ┌──100
   ┌──85
   │  └──71
┌──69
38
│     ┌──36
│  ┌──34
│  │  └──29
└──18
   └──4
 */
class InorderPrinter {

    var tree: BinaryTreeProtocol?
    
    fileprivate var rightAppend = ""
    fileprivate var leftAppend = ""
    fileprivate var blankAppend = ""
    fileprivate var lineAppend = ""
    
    
    init() {
        let length = 2
        rightAppend = String(format: "┌%@", "─".tk_repeat(count: length))
        leftAppend = String(format: "└%@", "─".tk_repeat(count: length))
        blankAppend = String.tk_blank(count: length + 1)
        lineAppend = String(format: "│%@", String.tk_blank(count: length))
    }
    
    
    static func printTree(_ tree: BinaryTreeProtocol) -> InorderPrinter {
        let print = InorderPrinter()
        print.tree = tree
        return print
    }
    
    func printIn() {
        printOut()
        print("\n")
    }
    
    func printOut() {
        print(printString() ?? "")
    }
    
    func printString() -> String? {
        var string = ""
        if let node = tree?.getRoot() as? TreeNode<Int> {
            let nodeStr = printStringNode(node, nodePrefix: "", leftPrefix: "", rightPrefix: "")
            string.append(nodeStr)
        }
        else if let node = tree?.getRoot() as? MapNode<Int, Int> {
            let nodeStr = printStringTreeNode(node, nodePrefix: "", leftPrefix: "", rightPrefix: "")
            string.append(nodeStr)
        }
        else if let node = tree?.getRoot() as? Int {
            let nodeStr = printStringComparable(node, nodePrefix: "", leftPrefix: "", rightPrefix: "")
            string.append(nodeStr)
        }
        
        if string.count > 0 {
            string = String(string.dropLast())
        }
        
        return string
    }
}

extension InorderPrinter {
    /**
     *  生成node节点的字符串
     *  nodePrefix node那一行的前缀字符串
     *  leftPrefix node整棵左子树的前缀字符串
     *  rightPrefix node整棵右子树的前缀字符串
     */
    fileprivate func printStringNode(_ node: TreeNode<Int>, nodePrefix: String, leftPrefix: String, rightPrefix: String) -> String {
        
        let left = tree?.left(node: node)
        let right = tree?.right(node: node)
        let string = tree?.string(node: node) ?? ""
        
        var length = string.count
        var rightString = rightPrefix
        var leftString = leftPrefix
        
        if length % 2 == 0 {
            length -= 1
        }
        length >>= 1
        
        var nodeString = ""
        if let item = right as? TreeNode<Int> {
            rightString.append(String.tk_blank(count: length))
            let newStr = printStringNode(item, nodePrefix: rightPrefix + rightAppend, leftPrefix: rightPrefix + lineAppend, rightPrefix: rightPrefix + blankAppend)
            nodeString.append(newStr)
        }
        nodeString.append(nodePrefix)
        nodeString.append(string)
        nodeString.append("\n")
        
        if let item = left as? TreeNode<Int> {
            leftString.append(String.tk_blank(count: length))
            let newStr = printStringNode(item, nodePrefix: leftPrefix + leftAppend, leftPrefix: leftPrefix + blankAppend, rightPrefix: leftPrefix + lineAppend)
            nodeString.append(newStr)
        }
        
        return nodeString
    }
    
    /**
     * 生成node节点的字符串
     *  nodePrefix node那一行的前缀字符串
     *  leftPrefix node整棵左子树的前缀字符串
     *  rightPrefix node整棵右子树的前缀字符串
     */
    fileprivate func printStringTreeNode(_ node: MapNode<Int, Int>, nodePrefix: String, leftPrefix: String, rightPrefix: String) -> String {
        let left = tree?.left(node: node)
        let right = tree?.right(node: node)
        let string = tree?.string(node: node) ?? ""
        
        var length = string.count
        var rightString = rightPrefix
        var leftString = leftPrefix
        
        if length % 2 == 0 {
            length -= 1
        }
        length >>= 1
        
        var nodeString = ""
        if let item = right as? MapNode<Int, Int> {
            rightString.append(String.tk_blank(count: length))
            let newStr = printStringTreeNode(item, nodePrefix: rightPrefix + rightAppend, leftPrefix: rightPrefix + lineAppend, rightPrefix: rightPrefix + blankAppend)
            nodeString.append(newStr)
        }
        nodeString.append(nodePrefix)
        nodeString.append(string)
        nodeString.append("\n")
        
        if let item = left as? MapNode<Int, Int> {
            leftString.append(String.tk_blank(count: length))
            let newStr = printStringTreeNode(item, nodePrefix: leftPrefix + leftAppend, leftPrefix: leftPrefix + blankAppend, rightPrefix: leftPrefix + lineAppend)
            nodeString.append(newStr)
        }
        
        return nodeString
    }
    
    /**
     * 生成node节点的字符串
     *  nodePrefix node那一行的前缀字符串
     *  leftPrefix node整棵左子树的前缀字符串
     *  rightPrefix node整棵右子树的前缀字符串
     */
    fileprivate func printStringComparable(_ node: Int, nodePrefix: String, leftPrefix: String, rightPrefix: String) -> String {
        let left = tree?.left(node: node)
        let right = tree?.right(node: node)
        let string = tree?.string(node: node) ?? ""
        
        var length = string.count
        var rightString = rightPrefix
        var leftString = leftPrefix
        
        if length % 2 == 0 {
            length -= 1
        }
        length >>= 1
        
        var nodeString = ""
        if let item = right as? Int {
            rightString.append(String.tk_blank(count: length))
            let newStr = printStringComparable(item, nodePrefix: rightPrefix + rightAppend, leftPrefix: rightPrefix + lineAppend, rightPrefix: rightPrefix + blankAppend)
            nodeString.append(newStr)
        }
        nodeString.append(nodePrefix)
        nodeString.append(string)
        nodeString.append("\n")
        
        if let item = left as? Int {
            leftString.append(String.tk_blank(count: length))
            let newStr = printStringComparable(item, nodePrefix: leftPrefix + leftAppend, leftPrefix: leftPrefix + blankAppend, rightPrefix: leftPrefix + lineAppend)
            nodeString.append(newStr)
        }
        
        return nodeString
    }
}
