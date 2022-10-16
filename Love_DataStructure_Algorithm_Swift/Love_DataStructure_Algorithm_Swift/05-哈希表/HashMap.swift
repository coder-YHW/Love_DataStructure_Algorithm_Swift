//
//  HashMap.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/15.
//

import Cocoa

// 注意闭包的写法: 1、any小写 2、协议不要: 3、多个协议用&隔开
typealias Visitor = ((any Hashable, any Comparable) -> ())

/// 哈希表
class HashMap<K: Hashable & Comparable, V: Comparable>: Map<K, V> {
    
    //MARK: - 属性
    fileprivate let capacity = 1 << 4 // tables桶数组长度
    fileprivate let loadFactor = 0.75  // 装填因子 = 哈希表节点总数量 / 哈希表桶数组长度; 如果装填因子超过0.75 就扩容为原来的2倍
    fileprivate var size = 0
    fileprivate var tables = [HashNode<K, V>?]() // <HashNode *> 红黑树根节点数组
    
    
    //MARK: - 构造函数
    override init() {
        tables = Array(repeating: nil, count: capacity)
    }
    
    
    //MARK: - override
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
        
        if size == 0 { return }
        
        for i in 0..<size {
            tables[i] = nil
        }
        size = 0
    }
    
    /**根据元素查询value*/
    override func get(key: K) -> V? {
        let node = getNodeFromKey(key)
        return node?.val
    }
    
    /**是否包含Key*/
    override func containsKey(key: K) -> Bool {
        return getNodeFromKey(key) != nil
    }
    
    /**是否包含Value*/
    override func containsValue(val: V) -> Bool {
        
        if size == 0 { return false }
        
        for node in tables { // 遍历每一张红黑树
            
            guard let rootNode = node else { // 0、root为nil 空树 下一个
                continue
            }
            
            let queue = SingleQueue<HashNode<K, V>>()
            queue.enQueue(rootNode) // 1、根节点入队 再层序遍历整棵树
            
            while !queue.isEmpty() {
                
                let currNode = queue.deQueue()
                if valEquals(val1: val, val2: currNode?.val) { // 2、value相等则包含
                    return true
                }
                
                if let left = node?.left {
                    queue.enQueue(left)
                }
                
                if let right = node?.left {
                    queue.enQueue(right)
                }
            }
        }
    
        return false // 3、遍历完都没找到 则不包含
    }
    
    /// 层序遍历
    func traversal(visitor : ((K?, V?) -> ())) {
        if size == 0 { return }
        
        let queue = SingleQueue<HashNode<K, V>>()
        
        for i in 0..<tables.count {
            if tables[i] == nil { continue }
            
            queue.enQueue(tables[i])
            
            while !queue.isEmpty() {
                if let node = queue.deQueue() {
                    
                    visitor(node.key, node.val)
                    
                    if let left = node.left {
                        queue.enQueue(left)
                    }
                    if let right = node.right {
                        queue.enQueue(right)
                    }
                }
            }
        }
    }
    
    /// 所有key
    func allKeys() -> [K] {
        var array = [K]()
        traversal { key, val in
            if let k = key {
                array.append(k)
            }
        }
        return array
    }
    
    /// 所有value
    func allValues() -> [V] {
        var array = [V]()
        traversal { key, val in
            if let v = val {
                array.append(v)
            }
        }
        return array
    }
    
    
    //MARK: 添加元素
    /**添加元素*/
    override func put(key: K?, val: V?) {
        // 0、可选类型非nil判断
        guard let key = key else { return }
        
        // 0、扩容检测
        ensureCapacity()
        
        let index = getHashIndexFromKey(key)
        var root = tables[index];
        
        // 1、添加第一个节点- 根节点
        if root == nil {
            root = HashNode(key, val)
            tables[index] = root // 将根节点放入到桶数组里 注意：一定不要忘了这一句
            size += 1
            
            // 5、添加之后调整节点
            afterPut(root!)
            
            return
        }
        
        // 2、添加的不是第一个节点 - 找到父节点
        // 此时哈希冲突（不同的key得哈希化后得到了相同的hashCode）
        var node = root
        var parent = root
        var cmp = 0
        
        while node != nil {
            
            if let key2 = node!.key {
                
                cmp = compare(key1: key, key2: key2)
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
                
            }else {
                return
            }
        }
        
        // 3、根据找到的父节点-插入新节点
        let newNode = HashNode(key, val, parent: parent)
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
    fileprivate func afterPut(_ node: HashNode<K, V>) {
        
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
    /**删除元素*/
    override func remove(key: K) {
        let node = getNodeFromKey(key)
        remove(node: node)
    }
    
    /**删除元素*/
    fileprivate func remove(node: HashNode<K, V>?) {
        
        // 0、可选类型非nil判断
        guard var node = node else { return }
        
        // 1、node的度为2 - 它的前驱节点或后继节点 只能是度为0或1的节点
        if node.hasTwoChildren() {
            // 1.1、找到后继节点 - 肯定是存在的
            let nextNode = nextNode(node)
            // 1.2、用后继节点的值覆盖度为2的节点
            node.key = nextNode!.key
            node.val = nextNode!.val
            node.hashCode = nextNode!.hashCode
            
            // 1.3、删除后继节点 - 用后继节点覆盖node 后续再删除node
            node = nextNode!
        }
        
        // 删除node节点（后面node的度必然是0或1）
        let replcaeNode = node.left != nil ? node.left : node.right
        
        if let replcaeNode { // 2、node的度为1 (更改子节点的parent➕更改父节点的左子树或右子树为replcaeNode)
            
            replcaeNode.parent = node.parent
            
            if node.parent == nil {
                let index = getHashIndexFromHashCode(node.hashCode)
                tables[index] = replcaeNode
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
                let index = getHashIndexFromHashCode(node.hashCode)
                tables[index] = nil
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
    fileprivate func afterRemove(_ node: HashNode<K, V>) {
        
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


//MARK: - 把key哈希化成hashIndex
extension HashMap {
    
    /// 把key转化成hashIndex
    fileprivate func getHashIndexFromKey(_ key: K?) -> Int {
        let hash = getHashCodeFromKey(key)
        return hash & (tables.count - 1)
    }
    
    /// 把key哈希化成hashCode
    fileprivate func getHashCodeFromKey(_ key: K?) -> Int {
        
        guard let key  else { return 0 }
        
        let hashCode = key.hashValue // 1、哈希函数
        
        return hashCode ^ (hashCode >> 32) // 2、向右偏移32位, 做异或操作
    }
    
    /// 把hashCode转化成hashIndex
    fileprivate func getHashIndexFromHashCode(_ hashCode: Int?) -> Int {

        guard let hashCode else { return 0 }
        
        return hashCode & (tables.count - 1) // 3、异或 (self.table.count - 1)
    }
}


//MARK: - 根据key的查找HashNode
extension HashMap {

    /// 1、根据key获取根节点root
    fileprivate func getRootFromKey(_ key: K?) -> HashNode<K, V>? {
        
        guard let key else { return nil }
        
        let index = getHashIndexFromKey(key)
        let root = tables[index]
        return root
    }
    
    /// 2、根据key查找node
    fileprivate func getNodeFromKey(_ key: K?) -> HashNode<K, V>? {
        
        let root = getRootFromKey(key)
        if root == nil { return nil}
        
        var node = root
        var cmp = 0
        
        while node != nil {
            
            if let key1 = key, let key2 = node?.key {
                
                cmp = compare(key1: key1, key2: key2)
                
                if cmp > 0 {
                    node = node?.right
                }else if cmp < 0 {
                    node = node?.left
                }else {
                    return node
                }
                
            }else {
                return nil
            }
        }
    
        return nil
    }
}

//MARK: - - 比较器
extension HashMap {
 
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
    
    /// 比较两个key大小
    fileprivate func compare(key1: K, key2: K, hashCode1: Int, hashCode2: Int) -> Int {
        
        var cmp = 0
        
        // 1、比较hsahCode
        if hashCode1 > hashCode2 {
            cmp = 1
        }else if hashCode1 < hashCode1 {
            cmp = -1
        }
        
        // 2、比较key
        if key1 > key2 {
            cmp = 1
        }else if key1 < key2 {
            cmp = -1
        }else {
            cmp = 0
        }
        
        return cmp
    }
}

//MARK:  - 平衡红黑树-旋转
extension HashMap {
    
    //MARK: - 左旋转
    /// 左旋转
    func rotateLeft(_ grand: HashNode<K,V>) {
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
    func rotateRight(_ grand: HashNode<K,V>) {
        
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
    func afterRotate(_ grand: HashNode<K,V>, parent: HashNode<K,V>, child: HashNode<K,V>?) {
        
        // 1.1、设置根节点 新parent的parent - parent指向根节点的线
        parent.parent = grand.parent
        
        // 1.2、让grand.parent指向parent - 假根节点指向parent的线
        if grand.isLeftChild() {
            grand.parent?.left = parent
        } else if grand.isRightChild() {
            grand.parent?.right = parent
        } else { // 真根节点
            let index = getHashIndexFromHashCode(grand.hashCode)
            tables[index] = parent
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
    func rotate(r: HashNode<K,V>,
                a: HashNode<K,V>?, b: HashNode<K,V>?, c: HashNode<K,V>?,
                d: HashNode<K,V>,
                e: HashNode<K,V>?, f: HashNode<K,V>?, g: HashNode<K,V>?) {
        
        // 1.1、让d成为这棵子树的根节点
        d.parent = r.parent
        // 1.2、让r.parent指向d
        if r.isLeftChild() {
            r.parent?.left = d
        } else if r.isRightChild() {
            r.parent?.right = d
        } else {
            let index = getHashIndexFromHashCode(r.hashCode)
            tables[index] = d
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
extension HashMap {
    
    /**给红黑树节点染色**/
    @discardableResult
    fileprivate func color(node: HashNode<K,V>?, color: Bool) -> HashNode<K,V>? {
        
        if let node {
            node.isRed = color
            return node
        }else {
            return nil
        }
    }
    
    /**将红黑树节点染成红色**/
    @discardableResult
    fileprivate func red(node: HashNode<K,V>?) -> HashNode<K,V>? {
        return color(node: node, color: true)
    }
    
    /**将红黑树节点染成黑色**/
    @discardableResult
    fileprivate func black(node: HashNode<K,V>?) -> HashNode<K,V>? {
        return color(node: node, color: false)
    }
    
    /**返回红黑树节点色值**/
    fileprivate func colorOf(node: HashNode<K,V>?) -> Bool {
        if let node {
            return node.isRed
        }else {
            return false
        }
    }
    
    /**红黑树节点是否是红色**/
    fileprivate func isRed(node: HashNode<K,V>?) -> Bool {
        return colorOf(node: node) == true
    }
    
    /**红黑树节点是否是黑色**/
    fileprivate func isBlack(node: HashNode<K,V>?) -> Bool {
        return colorOf(node: node) == false
    }
    
}


//MARK: 前驱节点 和 后继节点
extension HashMap {
    
    /** 获取当前节点的前序节点 */
    func prevNode(_ node: HashNode<K, V>?) -> HashNode<K, V>? {
        
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
    func nextNode(_ node: HashNode<K, V>?) -> HashNode<K, V>? {
        
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


//MARK: table数组的扩容与缩容
extension HashMap {
    
    /// 重置数组容量
    fileprivate func ensureCapacity() {
        // 1、装填因子<= 0.75 不扩容
        let oldCapacity = tables.count
        if Double(size) / Double(tables.count) <= loadFactor { return }

        // 2、装填因子>0.75 扩容为原来的2倍
        let oldTable = tables // 保存旧table
        tables = Array(repeating: nil, count: oldTable.count << 1)
        
        // 3、旧值设回
        for i in 0..<oldCapacity { // 3.1、遍历每一颗红黑树的根节点
//        tables[i] = oldTable[i]; 扩容之后 hashIndex变了 不能这么做
            
            guard let root = oldTable[i] else { continue }
            
            // 3.2、根据root 遍历每一颗红黑树的所有节点
            let queue = SingleQueue<HashNode<K, V>>()
            queue.enQueue(root)
            
            while !queue.isEmpty() {
                
                let node = queue.deQueue()
                // 3.3、把node从旧数组移动到新数组
//                moveNode(node) //  调到下面 避免node重置后无法入队
                
                if let left = node?.left {
                    queue.enQueue(left)
                }
                
                if let right = node?.right {
                    queue.enQueue(right)
                }
                
                // 3.3、把node从旧数组移动到新数组
                moveNode(node!) // node不可能为空
            }
        }
    }

    /// 把node从旧数组移动到新数组 -
    /// (跟添加很像 只是不需要创建新节点 将已存在的旧节点移到新数组即可)
    fileprivate func moveNode(_ newNode: HashNode<K, V>) {
        
        // 0、重置node所有线
        newNode.parent = nil
        newNode.left = nil
        newNode.right = nil
        newNode.isRed = true

        // 1、根据旧hashCode 重新计算索引 取出对应位置的root
        let index = getHashIndexFromHashCode(newNode.hashCode) // 重新计算索引
        var root = tables[index]
        
        // 2、root为空 添加根节点root到桶数组 修复红黑树性质
        if root == nil {
            root = newNode
            tables[index] = root
            
            afterPut(root!) // 修复红黑树性质
            return
        }

        // 3、root不为空 添加新的节点到对应红黑树 修复红黑树性质
        // 此时哈希冲突（不同的key得哈希化后得到了相同的hashCode）
        var parent = root
        var node = root
        var cmp = 0
        
        // 找到要添加位置的父节点
        while node != nil {
            
            if let key1 = newNode.key, let key2 = node!.key {
                
                cmp = compare(key1: key1, key2: key2, hashCode1: newNode.hashCode, hashCode2: node!.hashCode)
                parent = node
                
                if cmp > 0 {
                    node = node!.right
                } else if cmp < 0 {
                    node = node!.left
                }else {
                    // key相等 - 旧表里不可能存在相等的元素
                    return
                }
                
            }else {
                return
            }
        }

        // 4、newNode替换
        if cmp > 0 {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        newNode.parent = parent // 注意：记得加上这一句

        afterPut(newNode) // 5、修复红黑树性质
    }

}

//MARK: - Comparable协议
extension HashMap: Comparable {

    static func < (lhs: HashMap<K, V>, rhs: HashMap<K, V>) -> Bool {
        return lhs.count() < rhs.count()
    }
    
    static func > (lhs: HashMap<K, V>, rhs: HashMap<K, V>) -> Bool {
        return lhs.count() > rhs.count()
    }

    static func == (lhs: HashMap<K, V>, rhs: HashMap<K, V>) -> Bool {
        return lhs.count() == rhs.count()
    }
}

