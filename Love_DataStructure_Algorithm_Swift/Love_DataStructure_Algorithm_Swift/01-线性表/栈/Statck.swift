//
//  Statck.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/11.
//

import Cocoa

class Statck<E: Comparable> {
    
    //MARK: - 属性
    fileprivate var arrayList = ArrayList<E>()

    //MARK: - 方法
    /**元素个数*/
    func size() -> Int {
        return arrayList.count
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return arrayList.isEmpty()
    }
    
    /// 入栈
    func push(_ element: E?) {
        if let element {
            arrayList.add(element)
        }
    }
    
    /// 出栈
    @discardableResult
    func pop() -> E? {
        arrayList.remove(arrayList.count - 1)
    }
    
    /// 获取栈顶元素
    func peek() -> E? {
        return arrayList.get(arrayList.count - 1)
    }
    
    /**清空元素*/
    func clear() {
        arrayList.clear()
    }
}

// MARK: - 打印
extension Statck : CustomStringConvertible {
    
    var description: String {
        return arrayList.description
    }
}

extension Statck {
    /**
     * https://leetcode-cn.com/problems/valid-parentheses/submissions/
     * 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
     * 有效字符串需满足：左括号必须用相同类型的右括号闭合。左括号必须以正确的顺序闭合。
     * 示例: 输入：s = "()", 输出：true; 输入：s = "()]{}", 输出：false
     */
    func isValid(_ s: String) -> Bool {
        if s.count % 2 == 1 { return false }
        let map = [")": "(", "]": "[", "}": "{"]
        var stack = [String]()
        
        for i in s {
            let char = i.description
            let top = stack.last ?? ""
            if map[char] != nil {
                if stack.isEmpty || top != map[char] {
                    return false
                }
                stack.removeLast()
            } else {
                stack.append(char)
            }
        }
        
        return stack.count == 0
    }

    /**
     * https://leetcode-cn.com/problems/score-of-parentheses/
     * 给定一个平衡括号字符串 S，按下述规则计算该字符串的分数：
     * () 得 1 分。AB 得 A + B 分，其中 A 和 B 是平衡括号字符串。(A) 得 2 * A 分，其中 A 是平衡括号字符串。
     * 示例: 输入："()", 输出：1; 输入："(())", 输出：2; 输入: "()()", 输出: 2; 输入: "(()(()))", 输出: 6
     */
    func scoreOfParentheses(_ S: String) -> Int {
        let text = S
        if text.count % 2 == 1 || text.count < 2 { return 0 }
        
        let stack = Statck<Int>()
        for i in text {
            let char = i.description
            if char == "(" {
                stack.push(0)
            } else {
                let last = stack.pop() ?? 0
                let secord = stack.pop() ?? 0
                let new = max(last * 2, 1) + secord
                stack.push(new)
            }
        }
        return stack.pop() ?? 0
    }
}
