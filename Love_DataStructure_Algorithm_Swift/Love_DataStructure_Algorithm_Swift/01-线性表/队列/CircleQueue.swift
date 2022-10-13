//
//  CircleQueue.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/15.
//

import Cocoa

/// 单端循环队列 - 用优化后的动态数组实现
class CircleQueue<E: Comparable> {

    //MARK: - 属性
    fileprivate var arrayList = ArrayListUpgrade<E>()
    fileprivate var front = 0
    fileprivate var count = 0
    
    
    //MARK: - 方法
    /// 元素数量
    func size() -> Int {
        return arrayList.count
    }
    
    /**是否为空*/
    func isEmpty() -> Bool {
        return arrayList.isEmpty()
    }
    
    /**清除所有元素*/
    func clear() {
        arrayList.clear()
    }
    
    /// 入队
    func enQueue(_ element: E) {
        arrayList.add(element)
    }

    /// 出队
    func deQueue() -> E? {
        return arrayList.remove(0)
    }

    /// 获取队列的头元素
    func header() -> E? {
        return arrayList.get(0)
    }
    
//    func toString() -> String {
//        var text = "count = \(count), ["
//        for i in 0..<arrayList.count {
//            if i != 0 {
//                text += ", "
//            }
//            if let e = arrayList[i] {
//                text += "\(e)"
//            } else {
//                text += "nil"
//            }
//        }
//        text += "]"
//        return text
//    }
}


//extension CircleQueue {
//    /// 数组扩容
//    fileprivate func ensureCapacity(_ capacity: Int) {
//        let oldCapacity = arrayList.count
//        if capacity <= oldCapacity { return }
//        let newCapacity = oldCapacity + oldCapacity >> 1
//        
//        var newarrayList = [E?]()
//        for _ in 0..<newCapacity {
//            newarrayList.append(nil)
//        }
//        for i in 0..<count {
//            let index = getIndex(i)
//            newarrayList[i] = arrayList[index]
//        }
//        arrayList = newarrayList
//        front = 0
//    }
//    
//    /// 数组缩容
//    fileprivate func cutCapacity() {
//        let oldCapacity = arrayList.count
//        let newCapacity = oldCapacity >> 1
//        if count < newCapacity {
//            var newarrayList = [E?]()
//            for _ in 0..<newCapacity {
//                newarrayList.append(nil)
//            }
//            for i in 0..<count {
//                let index = getIndex(i)
//                newarrayList[i] = arrayList[index]
//            }
//            arrayList = newarrayList
//            front = 0
//        }
//    }
//    
//    /// 获取当前索引所在数组的真正索引
//    fileprivate func getIndex(_ index: Int) -> Int {
//        let newIndex = index + front
//        let length = arrayList.count
//        return newIndex >= length ? newIndex - length : newIndex
//    }
//}
