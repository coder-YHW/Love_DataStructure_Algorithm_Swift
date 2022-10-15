//
//  Map.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/11.
//

import Cocoa

class Map<K: Comparable, V: Comparable> {
    
                
    /**元素个数*/
    func count() -> Int {
        return 0
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return count() == 0
    }
    
    /**清除所有元素*/
    func clear() {}
    
    /**添加元素*/
    func put(key: K?, val: V?) {}
    
    /**根据key查询value*/
    func get(key: K) -> V? {
        return nil
    }
    
    /**删除元素*/
    func remove(key: K) {}
    
    /**是否包含Key*/
    func containsKey(key: K) -> Bool {
        return false
    }
    
    /**是否包含Value*/
    func containsValue(val: V) -> Bool {
        return false
    }

}
