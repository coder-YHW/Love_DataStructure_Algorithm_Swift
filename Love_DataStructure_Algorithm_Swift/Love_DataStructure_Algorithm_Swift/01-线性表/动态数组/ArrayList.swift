//
//  ArrayList.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/2.
//

import Cocoa

///动态数组
class ArrayList <E: Comparable>: AbstractList<E> {
    
    //MARK: - 属性
    fileprivate var elements : Array<E?>;
    
    //MARK: - 构造函数
    /// 初始化一个容量为capaticy的动态数组
    override init() {
//        elements = Array<E?>() // 初始化一个泛型空数组1
        elements = [E?]() // 初始化一个泛型空数组2
        for _ in 0..<Const.capacity {
            elements.append(nil)
        }
    }
    
    init(capacity : Int) {
        var capacity = capacity < Const.capacity ? Const.capacity : capacity
//        elements = Array<E?>() // 初始化一个泛型空数组1
        elements = [E?]() // 初始化一个泛型空数组2
        for _ in 0..<capacity {
            elements.append(nil)
        }
    }
    
    
    //MARK: - override
    /**清除所有元素*/
    override func clear() {
        for i in 0..<count {
            elements[i] = nil
        }
        count = 0
        
        // 数组缩容检查
        cutCapacity()
    }
    
    /**
     * 获取index位置的元素
     */
    override func get(_ index: Int) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        return elements[index]
    }
    
    /**
     * 替换index位置的元素
     */
    override func set(by index: Int, element: E) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        let oldElement = elements[index]
        elements[index] = element

        return oldElement
    }
    
    /**
     * 查看元素的索引
     */
    override func indexOfElement(_ element: E?) -> Int {
        
        for i in 0..<count {
            if elements[i] == element {
                return i
            }
        }
        
        return Const.notFound
    }
    
    
    //MARK: - 添加删除
    /** 在index位置插入一个元素*/
    override func add(by index: Int, element: E) {
        // 索引边界检查
        if rangeCheckForAdd(index) {
            return
        }
        
        // 数组扩容检查
        ensureCapacity(capacity: count + 1)
        
        // index位置后面的值依次往后移动一位 - 注意移动顺序
        if (count != 0) {
            for i in (index...count).reversed() {
                elements[i] = elements[i - 1];
            }
        }

        // 插入新值
        elements[index] = element;
        // 索引+=
        count += 1
    }
    
    /**删除index位置的元素*/
    override func remove(_ index: Int) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        // index位置后面的值依次往前移动一位 - 注意移动顺序
        let element = elements[index];
        for i in (index..<count) {
            elements[i] = elements[i+1];
        }
        
        elements[count-1] = nil;
        // 索引-=
        count -= 1
        
        // 数组缩容检查
        cutCapacity()
        
        return element
    }
    
    
    //MARK: - 动态数组扩容➕动态数组缩容
    /// 动态数组扩容
    private func ensureCapacity(capacity : Int) {
        
        let oldCapacity = elements.count;
        if capacity <= oldCapacity {
            return
        }
        
        let newCapacity = oldCapacity + oldCapacity>>1
        var newElements = Array<E?>()
        
        for _ in 0..<newCapacity {
            newElements.append(nil)
        }
        
        for i in 0..<count {
            newElements[i] = elements[i]
        }
        
        elements = newElements
        
        print("扩容为：\(newCapacity)")
    }
    
    /// 动态数组缩容
    fileprivate func cutCapacity() {
        
        let oldCapacity = elements.count
        let newCapacity = oldCapacity >> 1
        if (newCapacity < Const.capacity || newCapacity <= count ) {
            return
        }
        
        var newElements = [E?]()
        for _ in 0..<newCapacity {
            newElements.append(nil)
        }
        
        for i in 0..<count {
            newElements[i] = elements[i]
        }
        
        elements = newElements
        
        print("缩容为：\(newCapacity)")
    }
}


//MARK: - 打印 CustomStringConvertible,CustomDebugStringConvertible
extension ArrayList : CustomStringConvertible,CustomDebugStringConvertible { // 多个协议用,隔开
    
    var description: String {

        var text = "count = \(count), ["

        for i in 0..<elements.count {
            if i != 0 {
                text += ", "
            }

            if let e = elements[i] {
                text += "\(e)"
            } else {
                text += "nil"
            }
        }

        text += "]"

        return text
    }
    
    var debugDescription: String {
        
        var text = "count = \(count), ["

        for i in 0..<elements.count {
            if i != 0 {
                text += ", "
            }
            
            if let e = elements[i] {
                text += "\(e)"
            } else {
                text += "nil"
            }
        }
        
        text += "]"
        
        return text
    }
}
