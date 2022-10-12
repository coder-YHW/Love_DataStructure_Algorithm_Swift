//
//  AbstractList.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/8.
//

import Cocoa

/// 线性表-抽象基类 （实现部分通用接口 其他由子类实现）
class AbstractList<E: Comparable>: List<E> {

    //MARK: - 属性
    /**
     * 元素的数量
     */
    var count = 0
    
    
    //MARK: - override
    /**
     * 元素的数量
     */
    override func size() -> Int {
        return count
    }
    
    /**
     * 是否为空
     * @return
     */
    override func isEmpty() -> Bool {
        return count == 0
    }
    
    /**
     * 是否包含某个元素
     * @param element
     * @return
     */
    override func contains(_ element: E) -> Bool {
        return indexOfElement(element) != Const.notFound
    }

    /**
     * 添加元素到尾部
     * @param element
     */
    override func add(_ element: E) {
        add(by: count, element: element)
    }

    
    //MARK: - 索引越界错误处理
    /// 数组越界处理 - 错误处理
    func outOfBouns(_ index: Int) throws {
//        print("数组越界: index = \(index), count = \(count)")
        // 1、错误处理（抛异常）
        throw SomeError.outOfBounds(size:count, index:index)
    }
    
    /// 获取元素判断是否越界
    func rangeCheck(_ index: Int) -> Bool {
        if index < 0 || index >= count {
            
            // 2、错误处理（捕捉异常）
            do {
                try outOfBouns(index)
            } catch let error {
                
                switch error {
                case SomeError.outOfBounds(let size, let index):
                    print("索引越界: index = \(index), count = \(size)")
                    break
                    
                default:
                    print("其他错误")
                    break // break在至少有一行代码时 可以省略 不会穿透
                }
            }
            
            return true
        }
        return false
    }
    
    /**添加元素-判断越界*/
    func rangeCheckForAdd(_ index: Int) -> Bool  {
        if index < 0 || index > count {
            
            // 3、错误处理（捕捉异常）
            do {
                try outOfBouns(index)
            } catch SomeError.outOfBounds(let size, let index) {
                print("索引越界: index = \(index), count = \(size)")
            } catch {
                print("其他错误")
            }
            
            return true
        }
        return false
    }
}
