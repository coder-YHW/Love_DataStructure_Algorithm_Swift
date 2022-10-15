//
//  List.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/8.
//

import Cocoa


/// 线性表-通用接口设计
class List<E: Comparable> {

    //MARK: - 接口设计
    /**
     * 元素的数量
     */
    func size() -> Int {
        return 0
    }

    /**
     * 是否为空
     */
    func isEmpty() -> Bool {
        return true
    }
    
    /**
     * 清除所有元素
     */
    func clear() {}

    /**
     * 添加元素到尾部
     */
    func add(_ element: E) {}
    
    /**
     * 在index位置插入一个元素
     */
    func add(by index: Int, element: E) {}
    
    /**
     * 删除index位置的元素
     */
    @discardableResult
    func remove(_ index: Int) -> E? {
        return nil
    }
    
    /**
     * 替换index位置的元素
     */
    func set(by index: Int, element: E) -> E? {
        return nil
    }
    
    /**
     * 获取index位置的元素
     */
    func get(_ index: Int) -> E? {
        return nil
    }

    /**
     * 查看元素的索引
     * @param element
     * @return
     */
    func indexOfElement(_ element: E) -> Int {
        return 0
    }

    /**
     * 是否包含某个元素
     */
    func contains(_ element: E) -> Bool {
        return true
    }
}
