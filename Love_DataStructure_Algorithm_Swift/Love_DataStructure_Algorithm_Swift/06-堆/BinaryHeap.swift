//
//  BinaryHeap.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/29.
//
// 二叉堆

import Cocoa

/// /// 二叉堆（最大堆）-（完全二叉树、完全二叉堆）
/// 通过索引index拿到左右子树、父节点来操作完全二叉树
/// 思想是完全二叉树 实际操作的是数组
class BinaryHeap<E: Comparable>: AbstractHeap<E> {

    
    //MARK: - 属性
    fileprivate var elements = [E]()
    
    
    //MARK: - override构造函数
    init(vals: [E] = [], compare: ((E, E) -> Bool)? = nil) {
        super.init(compare: compare)
        
        if vals.count > 0 {
            vals.forEach({ elements.append($0) })
            heapify()
        }
    }
    
    
    //MARK: - override
    /// 元素的数量
    override func count() -> Int {
        return elements.count
    }
        
    /// 清空元素
    override func clear() {
        elements.removeAll()
    }
    
    /// 获得堆顶元素
    override func getTop() -> E? {
        if isEmpty() { return nil }
        return elements.first
    }
    
    /// 返回排序好的数组
    func getArray() -> [E] {
        return Array(elements)
    }
    
    
    //MARK: - 添加删除替换
    /**添加元素*/
    override func add(val: E) {
        // 1、将新元素加到数组最后
        elements.append(val)
        // 2、从（count-1）开始上滤- 性质修正
        shiftUp(elements.count - 1)
    }
    
    /**添加元素-数组*/
    override func addAll(vals: [E]) {
        for val in vals {
            add(val: val)
        }
    }
    
    /// 删除堆顶元素
    @discardableResult
    override func remove() -> E? {
        
        // 0、空堆
        if isEmpty() { return nil}
        // 1、获得堆顶元素
        let top = getTop()
        
        // 2、数组最后一个元素替换堆顶元素root
        let last = elements.last
        elements[0] = last!
        // 3、将数组最后一个元素删除
        elements.removeLast()
        
        // 4、从0开始下滤 - 性质修正
        siftDown(0)
        
        return top
    }
    
    /// 删除堆顶元素的同时插入一个新元素
    @discardableResult
    override func replace(val: E) -> E? {
        // 0、默认top为空
        var top: E? = nil
        
        if elements.count == 0 { // 1、特殊情况 堆为空 添加进去即可
            elements.append(val)
        } else {
            // 2、将新元素替换堆顶元素，再下滤
            top = elements.first
            elements[0] = val
            
            // 3、从0开始下滤 - 性质修正
            siftDown(0)
        }
        
        return top
    }
}


//MARK: - 上滤和下滤
extension BinaryHeap {
    //MARK: 上滤
    /// 上滤 - 时间复杂度 O(longN)
    fileprivate func shiftUp(_ index: Int) {
        
        // 1、currentIndex > 0时 沿着父节点往上找，比父节点大，就交换位置，比父节点小就退出循环
        // 2、currentIndex == 0时 说明找到父节点位置 不需要再交换位置 终止循环
        
        // 0、保存element的值
        var currentIndex = index
        let element = elements[currentIndex]
        
        // 1、是否还有父节点
        while currentIndex > 0 { // index == 0时 说明找到根节点位置 终止循环
            // 1.1父节点索引: floor((i - 1) / 2)
            let parentIndex = (currentIndex - 1) >> 1
            let parentVal = elements[parentIndex]
            
            // 1.2、比父节点小
            if !compare(lhs: element, rhs: parentVal) { break }
            
            // 1.3比父节点大 - 交换位置 父节点放到currentIndex位置
            elements[currentIndex] = parentVal
            // 1.4、重新赋值currentIndex - node的索引位置index来到父元素位置
            currentIndex = parentIndex
        }
        
        // 2、将element的值赋值到其索引位置
        elements[currentIndex] = element
    }
    
/**完全二叉树性质
*1、度为1的节点只有左子树
*2、度为1的节点要么是1个，要么是0个
*3、同样节点数量的二叉树，完全二叉树的高度最小
*4、如果一颗完全二叉树有n个节点，那么其叶子结点个数n0 = floor((n + 1) / 2)，非叶子结点个数n1 + n2 = floor(n / 2)
*5、如果一颗完全二叉树的高度为h (h>=1)，那么至少有2^(h - 1)个节点，至多有2^h - 1个节点（满二叉树）
*     h = floor(log2n) + 1
*/
    
    //MARK: 下滤
    /// 下滤 - 时间复杂度 O(longN)
    fileprivate func siftDown(_ index: Int) {
        
        // 0、保存element的值
        let value = elements[index]
        let half = elements.count >> 1
        var currentIndex = index
        
/**
 * 完全二叉树: 其叶子结点个数n0 = floor((n + 1) / 2)，非叶子结点个数n1 + n2 = floor(n / 2)
 * 完全二叉树: 第一个叶子节点之后，全是叶子节点
 * 完全二叉树: 第一个叶子节点的索引 == 非叶子节点的数量  (self.size / 2)
 *
 * 必须保证index位置是非叶子节点    —>    index < 第一个叶子节点的索引
 * 第一个叶子节点的索引 == 非叶子节点的数量    —>   index < half
*/
        // 1、必须保证index位置是非叶子节点
        while currentIndex < half {// 必须保证index位置是非叶子节点
            // 完全二叉树index的节点有2种情况 (index是父节点编号  左子节点编号：2*index + 1  右子节点编号：2*index + 2)
            // 1.1 只有左子节点 (有左子节点：2*index + 1 < self.size 无左子节点： 2*index + 1 >= self.size)
            // 1.2 同时有左右子节点 选出左右子节点最大的那个 (有右子节点：2*index + 2 < self.size 无右子节点：2*index + 2 >= self.size )
            
            // 2、取出左右子节点交大的childVal
            // 左子节点索引 （2*index + 1）
            var childIndex = currentIndex << 1 + 1
            var childVal = elements[childIndex] // 默认取左子节点
            
            // 右子节点索引 （2*index + 2）
            let rightIndex = childIndex + 1
            
            // 如果存在右子节点 且 右子节点>左子节点 那么用右子节点替换childVal、childIndex
            if rightIndex < elements.count && compare(lhs: elements[rightIndex], rhs: childVal) {
                childIndex = rightIndex
                childVal = elements[rightIndex]
            }
            
            // 3、value >= childVal break 比两个子节点都大
            if !compare(lhs: childVal, rhs: value) { break }
                
            // 4、value < childVal 继续下滤
            // 4.1、将子节点存放到index位置
            elements[currentIndex] = childVal
            // 4.2 更新currentIndex
            currentIndex = childIndex
        }
        
        // 5、将node的值赋值到其索引位置
        elements[currentIndex] = value
    }
    
    
    //MARK: 批量建堆
    /// 批量建堆
    fileprivate func heapify() {
//        // 自上而下的上滤 - 效率低 等价于一个个add
//        for i in 1..<elements.count {
//            shiftUp(i)
//        }
        
        // 自下而上的下滤 - 效率高
        let lastIndex = elements.count >> 1 - 1
        for i in (0...lastIndex).reversed() {
            siftDown(i)
        }
    }
}


//MARK: - 测试题
extension BinaryHeap {
    /// 找出数组中最大的前K个数
    func getMax(_ vals: [E], max: Int) -> [E] {
        if max >= vals.count { return vals }
        
        let heap = BinaryHeap(compare: <)
        for val in vals {
            if heap.count() < max {
                heap.add(val: val)
            } else if let top = heap.getTop(), top < val {
                heap.replace(val: val)
            }
        }
        
        return heap.getArray()
    }
}


//MARK: - 打印BinaryHeap
extension BinaryHeap: BinaryTreeProtocol {
    func getRoot() -> Any? {
        return 0
    }
    
    func left(node: Any?) -> Any? {
        if let index = node as? Int {
            let childIndex = index << 1 + 1
            return childIndex < elements.count ? childIndex as Any : nil
        }
        return nil
    }
    
    func right(node: Any?) -> Any? {
        if let index = node as? Int {
            let childIndex = index << 1 + 2
            return childIndex < elements.count ? childIndex as Any : nil
        }
        return nil
    }
    
    func string(node: Any?) -> String {
        if let index = node as? Int, index < elements.count {
            return "\(elements[index])"
        }
        return "-"
    }
}
