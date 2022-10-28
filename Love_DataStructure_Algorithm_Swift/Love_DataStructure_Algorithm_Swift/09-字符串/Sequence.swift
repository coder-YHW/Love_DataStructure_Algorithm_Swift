//
//  Sequence.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/24.
//

import Foundation

/// 串
class Sequence {
    
    //MARK: - 字符串匹配算法1 - 滑动窗口
    /// 字符串匹配1
    func indexOf1(text: String, pattern: String) -> Int {
        let tlen = text.count, plen = pattern.count
        if tlen == 0 || plen == 0 || tlen < plen  {
            return Const.notFound
        }
        
        let textArr = Array(text), patternArr = Array(pattern)
        var pi = 0, ti = 0
        
//        while pi < plen && ti < tlen {
        while pi < plen && ti - pi <= tlen - plen {
            
            if patternArr[pi] == textArr[ti] {
                pi += 1
                ti += 1
            }else {
                ti = ti - pi + 1
                pi = 0
            }
        }
        
        return pi == plen ? ti - pi : Const.notFound
    }
    
    /// 字符串匹配2
    func indexOf2(text: String, pattern: String) -> Int {
        let tlen = text.count, plen = pattern.count
        if tlen == 0 || plen == 0 || tlen < plen  {
            return Const.notFound
        }
        
        let textArr = Array(text), patternArr = Array(pattern)
        var pi = 0, ti = 0
        
        while pi < plen && ti <= tlen - plen {
            
            if patternArr[pi] == textArr[ti + pi] {
                pi += 1
            }else {
                ti += 1
                pi = 0
            }
        }
        
        return pi == plen ? ti : Const.notFound
    }
    
    
    //MARK: - 字符串匹配算法2 - KMP（重点）
    
    
    //MARK: - 字符串匹配算法2 - BM
    
    
    //MARK: - 字符串匹配算法2 - KR
    
    
    //MARK: - 字符串匹配算法2 - Sunday
    
    
    
}
