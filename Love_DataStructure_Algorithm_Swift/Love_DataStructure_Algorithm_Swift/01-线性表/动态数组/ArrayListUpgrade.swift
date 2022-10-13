//
//  ArrayListUpgrade.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/12.
//

import Cocoa

/// 动态数组加强版 - 优化环形内存
class ArrayListUpgrade<E: Comparable>: AbstractList<E> {

    //MARK: - 属性
    fileprivate var elements : Array<E?>
    /// 数组首元素索引
    fileprivate var front : Int
    
    //MARK: - 构造函数
    /// 初始化一个容量为capaticy的动态数组
    override init() {
//        elements = Array<E?>() // 初始化一个泛型空数组1
        elements = [E?]() // 初始化一个泛型空数组2
        for _ in 0..<Const.capacity {
            elements.append(nil)
        }
        front = 0
    }
    
    init(capacity : Int) {
        var capacity = capacity < Const.capacity ? Const.capacity : capacity
//        elements = Array<E?>() // 初始化一个泛型空数组1
        elements = [E?]() // 初始化一个泛型空数组2
        for _ in 0..<capacity {
            elements.append(nil)
        }
        front = 0
    }
    
    //MARK: - override
    /**清除所有元素*/
    override func clear() {
        for i in 0..<count {
            // 索引映射
            let newIndex = getIndex(index: i);
            elements[newIndex] = nil
        }
        count = 0
        front = 0
        
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
        
        // 索引映射
        let newIndex = getIndex(index: index);
        return elements[newIndex]
    }
    
    /**
     * 替换index位置的元素
     */
    override func set(by index: Int, element: E) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        // 索引映射
        let newIndex = getIndex(index: index);
        let oldElement = elements[newIndex]
        elements[newIndex] = element

        return oldElement
    }
    
    /**
     * 查看元素的索引
     */
    override func indexOfElement(_ element: E?) -> Int {
        
        for i in 0..<count {
            
            // 索引映射
            let newIndex = getIndex(index: i);
            if elements[newIndex] == element {
                return i
            }
        }
        
        return Const.notFound
    }
    
    
    //MARK: - 添加删除 - 只需要优化添加删除的index 其他index不变
    /** 在index位置插入一个元素*/
    override func add(by index: Int, element: E) {
        // 索引边界检查
        if rangeCheckForAdd(index) {
            return
        }
        
        // 数组扩容检查
        ensureCapacity(capacity: count + 1)
        
        var newIndex = getIndex(index: index) // 当前index索引映射
        let lastIndex = getIndex(index: count) // 最后一个元素索引映射 - 添加的last跟删除的last不一样
        
        if newIndex == lastIndex { // 1、往数组末尾插入元素
            // 插入新值
            elements[newIndex] = element
            
        }else if newIndex == front { // 2、往数组开头插入元素
            // 索引映射
            newIndex = getIndex(index: -1)
            // 插入新值
            elements[newIndex] = element
            // 更新首元素
            front = newIndex
            
        }else { // 3、往数组中间插入元素
            
            // index位置后面的值依次往后移动一位 - 注意移动顺序
            for i in (index...count).reversed() {
                // 索引映射
                let curr = getIndex(index: i)
                let prev = getIndex(index: i-1) // 不能curr-1 可能会为负数
                elements[curr] = elements[prev];
            }
            
            // 插入新值
            elements[newIndex] = element;
        }

        // 索引+=
        count += 1
    }
    
    /**删除index位置的元素*/
    override func remove(_ index: Int) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        var newIndex = getIndex(index: index) // 当前index索引映射
        let lastIndex = getIndex(index: count-1) // 最后一个元素索引映射 - 添加的last跟删除的last不一样
        let element = elements[newIndex];
        
        if newIndex == lastIndex { // 1、在数组末尾删除元素
            // 删除旧值
            elements[newIndex] = nil
            
        }else if newIndex == front { // 2、在数组开头删除元素
            // 删除旧值
            elements[newIndex] = nil
            // 索引映射
            newIndex = getIndex(index: 1)
            // 更新首元素
            front = newIndex
            
        }else { // 3、在数组中间删除元素
         
            // index位置后面的值依次往前移动一位 - 注意移动顺序
            for i in (index..<count) {
                // 索引映射
                let curr = getIndex(index: i)
                let next = getIndex(index: i+1) // 不能curr+1 可能会超过count
                elements[curr] = elements[next];
            }
            
            elements[lastIndex] = nil;
        }
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
            let index = getIndex(index: i)
            newElements[i] = elements[index]
        }
        
        elements = newElements
        
        print("扩容为:\(newCapacity)")
    }
    
    /// 动态数组缩容
    fileprivate func cutCapacity() {
        
        let oldCapacity = elements.count
        let newCapacity = oldCapacity >> 1
        if (newCapacity < Const.capacity || newCapacity <= count) {
            return
        }
        
        var newElements = [E?]()
        for _ in 0..<newCapacity {
            newElements.append(nil)
        }
        
        for i in 0..<count {
            let index = getIndex(index: i)
            newElements[i] = elements[index]
        }
        
        elements = newElements
        
        print("缩容为：\(newCapacity)")
    }
    
    //MARK: - 动态数组索引映射 - 对i和index索引映射
    /// 获取真正插入位置的索引 - 对i和index索引映射
    fileprivate func getIndex(index : Int) -> Int {
        
        var newIndex = front + index
        
        if newIndex < 0 { // newIndex < 0
            newIndex += elements.count
        }else if newIndex >= elements.count { // newIndex >= elements.count
            newIndex -= elements.count
        }else {
            // 不需要改变 front + index
        }
        
        return newIndex
    }
}


//MARK: - 打印 CustomStringConvertible,CustomDebugStringConvertible
extension ArrayListUpgrade : CustomStringConvertible,CustomDebugStringConvertible { // 多个协议用,隔开
    
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


