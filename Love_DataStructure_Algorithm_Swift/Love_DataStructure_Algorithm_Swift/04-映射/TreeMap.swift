//
//  TreeMap.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/12.
//

import Cocoa

// 注意闭包的写法: 1、any小写 2、协议不要: 3、多个协议用&隔开
typealias MapVisitor = ((any Comparable, any Comparable) -> ())


/// 映射 - 用红黑树实现
class TreeMap<K: Comparable, V: Comparable>: Map<K, V> {
    
    
    // MARK: - 属性
    /// 元素数量
    fileprivate var size = 0
    /// 根节点
    fileprivate var root: MapNode<K, V>?
    
    
    // MARK: - override
    /**元素个数*/
    override func count() -> Int {
        return size
    }
    
    /**是否为空*/
    override func isEmpty() -> Bool {
        return size == 0
    }
    
    /**清除所有元素*/
    override func clear() {
        root = nil
        size = 0
    }
    
    /** 根据key查找node */
    fileprivate func getNodeFromKey(_ key: K) -> MapNode<K, V>? {
        
        var node = root
        var cmp = 0
        
        while node != nil {
            
            if let key2 = node?.key {
                
                cmp = compare(key1: key, key2: key2)
    
                if cmp > 0 { // cmp > 0 右子树
                    node = node?.right
                }else if cmp < 0 { // cmp < 0 左子树
                    node = node?.left
                }else { // cmp == 0 就是这个节点
                    return node
                }
                
            }else {
                print("node?.element为nil")
                return nil
            }
        }
        
        return node
    }
    
    /**根据key查询value*/
    override func get(key: K) -> V? {
        if let node = getNodeFromKey(key) {
            return node.val
        }
        return nil
    }
    
    /**是否包含Key*/
    override func containsKey(key: K) -> Bool {
        return getNodeFromKey(key) != nil
    }
    
    /**是否包含Value-层序遍历*/
    override func containsValue(val: V) -> Bool {
        
        guard let root else { return false}
        
        let queue = SingleQueue<MapNode<K, V>>()
        queue.enQueue(root)
        
        while !queue.isEmpty() {
            
            let node = queue.deQueue()
            if  valEquals(val1: val, val2: node?.val) {
                return true
            }
            
            if node?.left != nil {
                queue.enQueue(node?.left)
            }
            
            if node?.right != nil {
                queue.enQueue(node?.right)
            }
        }

        return false
    }
    
    /** 中序遍历 */
    func traversal(mapVisitor: ((K, V) -> ())? = nil) {
     
        guard let root else {
            return
        }
        
        let queue = SingleQueue<MapNode<K, V>>()
        queue.enQueue(root) // // 0、根节点入队
        
        while !queue.isEmpty() {
            
            guard let node = queue.deQueue() else {
                return
            }
//            print(node)
            if let mapVisitor, let value = node.val {
                mapVisitor(node.key, value)
            }else {
                print(node)
            }
            
            if let left = node.left { // 1、左子节点入队
                queue.enQueue(left)
            }
            
            if let right = node.right { // 2、右子节点入队
                queue.enQueue(right)
            }
        }
        
    }
    
    /// 所有key
    func allKeys() -> [K] {
        var array = [K]()
        traversal { key, val in
            array.append(key)
        }
        return array
    }
    
    /// 所有value
    func allValues() -> [V] {
        var array = [V]()
        traversal { key, val in
            array.append(val)
        }
        return array
    }
    
    
    //MARK: 添加元素
    /**添加元素*/
    override func put(key: K?, val: V?) {
        // 0、可选类型非nil判断
        guard let key = key else { return }
        
        // 1、添加第一个节点- 根节点
        if root == nil {
            root = MapNode(key, val)
            size += 1
            
            // 5、添加之后调整节点
            afterPut(root!)
            
            return
        }
        
        // 2、添加的不是第一个节点 - 找到父节点
        var node = root
        var parent = root
        var cmp = 0
        
        while node != nil {
            
            cmp = compare(key1: key, key2: node!.key)
            parent = node // 更新父节点
            
            if cmp > 0 { // cmp > 0 右子树
                node = node?.right
            }else if cmp < 0 { // cmp < 0 左子树
                node = node?.left
            }else { // cmp == 0 覆盖
                node?.key = key
                node?.val = val
                
                return
            }
        }
        
        // 3、根据找到的父节点-插入新节点
        let newNode = MapNode(key, val, parent: parent)
        if cmp > 0 {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        
        // 4、索引+= 1
        size += 1
        
        // 5、添加之后调整节点
        afterPut(newNode)
    }
    
    /// 添加node之后恢复红黑树性质
    fileprivate func afterPut(_ node: MapNode<K, V>) {
        
        guard let parent = node.parent else {
            // 1、添加的是根节点,或者上溢到达了根节点
            // 1.1、将自己染黑就行了
            black(node: node)
            return
        }
        
        // 红黑红、黑红、红黑、黑 - 总共12种情况
        // 2、如果父节点是黑色,直接返回 - 新添加的节点默认是红色的
        if isBlack(node: parent) { //（红黑红、黑红、红黑、黑 - 往黑节点上添加）4种情况
            return
        }
        
        // 叔父节点
        let uncle = parent.sibling()
        // 祖父节点
        let grand = parent.parent
        
        // 3、父节点是红色&&叔父节点是红色[B树节点上溢] - （红黑红-往红节点上添加）4种情况
        if isRed(node: uncle) {
            // 3.1、将grand染红，父节点、叔父节点都染黑
            black(node: uncle)
            black(node: parent)
            
            // 3.2、等价于 - 将祖父节点当做是新添加的节点
            if let node = grand {
                red(node: grand)
                afterPut(node)
            }
            return
        }
        
        // 4、父节点是红色&&叔父节点不是红色 - （黑红或红黑-往红节点上添加）4种情况
        if parent.isLeftChild() { // L
            if node.isLeftChild() { // LL
                // 4.1、将grand染红，父节点染黑，再旋转
                red(node: grand)
                black(node: parent)
            } else { // LR
                // 4.2、将grand染红，自己染黑，再旋转
                red(node: grand)
                black(node: node)
                rotateLeft(parent)
            }
            
            if let grand  {
                rotateRight(grand)
            }
            
        } else { // R
            if node.isLeftChild() { // RL
                // 4.3、将grand染红，自己染黑，再旋转
                red(node: grand)
                black(node: node)
                rotateRight(parent)
            } else { // RR
                // 4.4、将grand染红，父节点染黑，再旋转
                red(node: grand)
                black(node: parent)
            }
            
            if let grand {
                rotateLeft(grand)
            }
        }
    }
    
    //MARK: 删除元素
    override func remove(key: K) {
        remove(getNodeFromKey(key))
    }
    
    /**删除元素*/
    fileprivate func remove(_ node: MapNode<K, V>?) {
        
        // 0、可选类型非nil判断
        guard var node else { return }
        
        // 1、node的度为2 - 它的前驱节点或后继节点 只能是度为0或1的节点
        if node.hasTwoChildren() {
            // 1.1、找到后继节点 - 肯定是存在的
            let nextNode = nextNode(node)
            // 1.2、用后继节点的值覆盖度为2的节点
            node.key = nextNode!.key
            node.val = nextNode!.val
            
            // 1.3、删除后继节点 - 用后继节点覆盖node 后续再删除node
            node = nextNode!
        }
        
        // 删除node节点（后面node的度必然是0或1）
        let replcaeNode = node.left != nil ? node.left : node.right
        
        if let replcaeNode { // 2、node的度为1 (更改子节点的parent➕更改父节点的左子树或右子树为replcaeNode)
            
            replcaeNode.parent = node.parent
            
            if node.parent == nil {
                root = replcaeNode
            }else if node.isLeftChild() {
                node.parent?.left = replcaeNode
            }else if node.isRightChild() {
                node.parent?.right = replcaeNode
            }
            
            // 索引-=1
            size -= 1
            
            // 删除节点后平衡红黑树
            afterRemove(replcaeNode)
            
        }else { // 3、node的度为0 （更改父节点的左子树或右子树为replcaeNode == nil）
            
            if node.parent == nil {
                root = nil
            }else if node.isLeftChild() {
                node.parent?.left = nil
            }else if node.isRightChild() {
                node.parent?.right = nil
            }
            
            // 索引-=1
            size -= 1
            
            // 删除节点后平衡红黑树
            afterRemove(node)
        }
    }
    
    /// 删除node之后恢复红黑树性质
    fileprivate func afterRemove(_ node: MapNode<K, V>) {
        
        // 1、如果删除的节点是红色 直接删除-不做任何调整 （合并到下面去判断）
        // if ([self isRed:node]) return; // 直接删除-不做任何调整

        /*1、如果删除的节点是红色 直接删除-不做任何调整
         *2、如果删除的黑色节点有2个Red子节点，会用前驱或者后继节点去替代删除（不用考虑这种情况）
         *
         *   注意：当删除的节点度为1时，afterRemove传进来的不是node，而是replcaeNode（红黑树要求 不影响AVL树）
         *3、如果删除的黑色节点只有1个Red子节点，用以取代删除节点的子节点replcaeNode是红色
         *   只需要把replcaeNode染黑就可以保持红黑树性质
         */
        if isRed(node: node) { // 如果删除的节点是红色 || 用以取代删除节点的子节点replcaeNode是红色
            black(node: node)
            return
        }

        // 4、删除的是根节点
        guard let parent = node.parent else {
            return
        }

        // 5、删除的是黑色叶子节点[下溢]
        // 判断被删除的node是左还是右
        let isLeft = parent.left == nil || node.isLeftChild() // 注意这2种情况
        var sibling = isLeft ? parent.right : parent.left

        if isLeft { // 5.1、被删除的节点在左边,兄弟节点在右边
           
            if isRed(node: sibling) == true { // 5.1.1、红兄弟节点 -（把红兄弟的黑色子节点 通过旋转转成兄弟节点是黑色的情况来处理）
                black(node: sibling)
                red(node: parent)
                rotateLeft(parent)
  
                // 更换兄弟
                sibling = parent.right;
            }

            // 5.1.2、黑兄弟节点必然是黑色
            if isBlack(node: sibling?.left) && isBlack(node: sibling?.right) { //
                // 5.1.2.1、黑兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
                let parentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                
                if parentBlack { // 5.1.2.2、如果parent为Black，会导致parent下溢
                    afterRemove(parent)
                }
                
            } else { // 5.1.2.3、黑兄弟节点至少有一个红色子节点,向兄弟节点借红色子节点
                // 黑兄弟节点的左边是黑色,兄弟要先旋转
                if var sibling, isBlack(node: sibling.right) { // sibling-RL
                    rotateRight(node)
                    sibling = parent.right!
                }

                // sibling-RR
                color(node: sibling, color: colorOf(node: parent)) // 旋转之后的中心节点继承parent的颜色
                black(node: sibling?.right) // 旋转之后的左右节点染为黑色
                black(node: parent) // 旋转之后的左右节点染为黑色
                rotateLeft(parent)
            }
        } else { // 5.2、被删除的节点在右边,兄弟节点在左边
            
            if isRed(node: sibling) { // 5.2.1、红兄弟节点 -（把红兄弟的黑色子节点 通过旋转转成兄弟节点是黑色的情况来处理）
                black(node: sibling)
                red(node: parent)
                rotateRight(parent)

                // 更换兄弟
                sibling = parent.left;
            }

            // 5.2.2、兄弟节点必然是黑色
            if isBlack(node: sibling?.left) && isBlack(node: sibling?.right) {
                // 3.2.2.1、黑兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
                let parentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                
                if parentBlack { // 5.2.2.2、如果parent为Black，会导致parent下溢
                    afterRemove(parent)
                }

            } else { // 5.2.2.3、黑兄弟节点至少有一个红色子节点,向兄弟节点借红色子节点
                // 兄弟节点的左边是黑色,兄弟要先旋转
                if var sibling, isBlack(node: sibling.left) { // sibling-LR
                    rotateLeft(node)
                    sibling = parent.left!
                }

                // sibling-LL
                color(node: sibling, color: colorOf(node: parent)) // 旋转之后的中心节点继承parent的颜色
                black(node: sibling?.left) // 旋转之后的左右节点染为黑色
                black(node: parent) // 旋转之后的左右节点染为黑色
                rotateRight(parent)
            }
        }
    }
    
}

//MARK: - 比较器
extension TreeMap {
    
    /// 比较两个key大小
    fileprivate func compare(key1: K, key2: K) -> Int {
        
        if key1 > key2 {
            return 1
        }else if key1 < key2 {
            return -1
        }else {
            return 0
        }
    }
    
    /// 比较两个val是否相等
    fileprivate func valEquals(val1: V?, val2: V?) ->Bool {
        return val1 == nil ? val2 == nil : val1 == val2
    }
}

//MARK:  - 平衡红黑树-旋转
extension TreeMap {
    
    //MARK: - 左旋转
    /// 左旋转
    func rotateLeft(_ grand: MapNode<K,V>) {
        // 1、找到parent和child
        guard let parent = grand.right else {
            return
        }
        let child = parent.left // 退化成链表的时候child不一定存在
        
        // 2、旋转grand、parent和child - 改动2根线
        grand.right = child
        parent.left = grand
        
        // 3、依次更新parent、child、grand的parent
        afterRotate(grand, parent: parent, child: child)
    }
    
    //MARK: - 右旋转
    /// 右旋转
    func rotateRight(_ grand: MapNode<K,V>) {
        
        // 1、找到parent和child
        guard let parent = grand.left else {
            return
        }
        let child = parent.right // 退化成链表的时候child不一定存在
        
        // 2、旋转grand、parent和child - 改动2根线
        grand.left = child
        parent.right = grand
        
        // 3、依次更新parent、child、grand的parent
        afterRotate(grand, parent: parent, child: child)
    }
    
    //MARK: - 旋转之后更新parent和height
    /// 旋转之后 - 依次更新parent、child、grand的parent
    /// 旋转之后记得更新高度 - 子类重写
    func afterRotate(_ grand: MapNode<K,V>, parent: MapNode<K,V>, child: MapNode<K,V>?) {
        
        // 1.1、设置根节点 新parent的parent - parent指向根节点的线
        parent.parent = grand.parent
        
        // 1.2、让grand.parent指向parent - 假根节点指向parent的线
        if grand.isLeftChild() {
            grand.parent?.left = parent
        } else if grand.isRightChild() {
            grand.parent?.right = parent
        } else { // 真根节点
            root = parent
        }
        
        // 2、更新child的parent - 退化成链表的时候child不一定存在
        if let child {
            child.parent = grand
        }
        
        // 3、更新grand的parent
        grand.parent = parent
    }
    
    //MARK: - 统一旋转 - 依次更新b、f、d的高度
    /// 平衡旋转 - - 旋转之后记得更新高度 - 子类重写
    func rotate(r: MapNode<K,V>,
                a: MapNode<K,V>?, b: MapNode<K,V>?, c: MapNode<K,V>?,
                d: MapNode<K,V>,
                e: MapNode<K,V>?, f: MapNode<K,V>?, g: MapNode<K,V>?) {
        
        // 1.1、让d成为这棵子树的根节点
        d.parent = r.parent
        // 1.2、让r.parent指向d
        if r.isLeftChild() {
          r.parent?.left = d
        } else if r.isRightChild() {
          r.parent?.right = d
        } else {
          root = d
        }

        // 2、a-b-c
        b?.left = a
        if let a {
            a.parent = b
        }
        
        b?.right = c
        if let c {
            c.parent = b
        }
        
    
        // 3、e-f-g
        f?.left = e
        if let e {
            e.parent = f
        }
        
        f?.right = g
        if let g {
            g.parent = f
        }

        // 4、b-d-f
        d.left = b
        d.right = f
        b?.parent = d
        f?.parent = d
    }
    
}


//MARK:  - 平衡红黑树-染色
extension TreeMap {
    
    /**给红黑树节点染色**/
    @discardableResult
    fileprivate func color(node: MapNode<K,V>?, color: Bool) -> MapNode<K,V>? {
        
        if let node {
            node.isRed = color
            return node
        }else {
            return nil
        }
    }
    
    /**将红黑树节点染成红色**/
    @discardableResult
    fileprivate func red(node: MapNode<K,V>?) -> MapNode<K,V>? {
        return color(node: node, color: true)
    }
    
    /**将红黑树节点染成黑色**/
    @discardableResult
    fileprivate func black(node: MapNode<K,V>?) -> MapNode<K,V>? {
        return color(node: node, color: false)
    }
    
    /**返回红黑树节点色值**/
    fileprivate func colorOf(node: MapNode<K,V>?) -> Bool {
        if let node {
            return node.isRed
        }else {
            return false
        }
    }
    
    /**红黑树节点是否是红色**/
    fileprivate func isRed(node: MapNode<K,V>?) -> Bool {
        return colorOf(node: node) == true
    }
    
    /**红黑树节点是否是黑色**/
    fileprivate func isBlack(node: MapNode<K,V>?) -> Bool {
        return colorOf(node: node) == false
    }
    
}


//MARK: 前驱节点 和 后继节点
extension TreeMap {
    
    /** 获取当前节点的前序节点 */
    func prevNode(_ node: MapNode<K, V>?) -> MapNode<K, V>? {
        
        if node == nil || node?.left == nil {
            return nil
        }
        
        var currNode = node?.left
        while currNode?.right != nil {
            currNode = currNode?.right
        }
        
        return currNode
    }
    
    /** 获取当前节点的后序节点*/
    func nextNode(_ node: MapNode<K, V>?) -> MapNode<K, V>? {
        
        if node == nil || node?.right == nil {
            return nil
        }
        
        var currNode = node?.right
        while currNode?.left != nil {
            currNode = currNode?.left
        }
        
        return currNode
    }
}


// MARK: - 打印TreeMap
extension TreeMap: BinaryTreeProtocol {
    
    func getRoot() -> Any? {
        return root as Any
    }
    
    func left(node: Any?) -> Any? {
        if let n = node as? MapNode<K,V> {
            return n.left as Any
        }
        return NSObject()
    }
    
    func right(node: Any?) -> Any? {
        if let n = node as? MapNode<K,V> {
            return n.right as Any
        }
        return NSObject()
    }
    
    func string(node: Any?) -> String {
        
        if let mapNode = node as? MapNode<K,V> {
            
            if mapNode.isRed {
                return "R_\(mapNode.key):\(mapNode.val!)"
            }else {
                return "\(mapNode.key):\(mapNode.val!)"
            }
        }
        
        return "-"
    }
}

