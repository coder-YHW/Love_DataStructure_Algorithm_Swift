//
//  main.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Foundation

//print("Hello, World!")

//MARK: - 动态数组测试用例
/// 动态数组测试用例
func testArrayList() {
    
    let arrayList = ArrayListUpgrade<Int>()
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    for obj in data {
        arrayList.add(obj)
    }
    for obj in data {
        arrayList.add(obj)
    }
    print(arrayList)
    
    for _ in 0...8 {
        arrayList.remove(0)
        print(arrayList)
    }

//    arrayList.remove(5)
//    print(arrayList)
//
//    arrayList.add(by: 10, element: 20)
//    print(arrayList)
//
//    arrayList.set(by: 5, element: 6)
//    print(arrayList)
//
//    arrayList.clear()
//    print(arrayList)
    
    
//    let arrayList = ArrayListUpgrade<Int>()
//    print(arrayList)
//    
//    // 在数组开头添加元素
//    arrayList.add(by: 0, element: 0)
//    print(arrayList)
//    arrayList.add(by: 0, element: 1)
//    print(arrayList)
//    arrayList.add(by: 0, element: 2)
//    print(arrayList)
//    arrayList.add(by: 0, element: 3)
//    print(arrayList)
    
    // 测试查询修改
//    let a = arrayList.get(3)
//    print(a ?? "nil")
//    arrayList.set(by: 3, element: 10)
//    print(arrayList)
//    let b = arrayList.indexOfElement(2)
//    print(b)
    
//    // 删除数组开头元素
//    arrayList.remove(0)
//    print(arrayList)
//    arrayList.remove(0)
//    print(arrayList)
//    arrayList.remove(0)
//    print(arrayList)
//    arrayList.remove(0)
//    print(arrayList)
    
//    // 在数组中间添加元素
//    arrayList.add(by: 1, element: 4)
//    print(arrayList)
//    arrayList.add(by: 1, element: 5)
//    print(arrayList)
//    arrayList.add(by: 1, element: 6)
//    print(arrayList)
//    arrayList.add(by: 1, element: 7)
//    print(arrayList)
//
//    // 删除数组中间元素
//    arrayList.remove(1)
//    print(arrayList)
//    arrayList.remove(1)
//    print(arrayList)
//    arrayList.remove(1)
//    print(arrayList)
//    arrayList.remove(1)
//    print(arrayList)
    
    // 在数组末尾添加元素
//    arrayList.add(0)
//    print(arrayList)
//    arrayList.add(1)
//    print(arrayList)
//    arrayList.add(2)
//    print(arrayList)
//    arrayList.add(3)
//    print(arrayList)
    
    // 删除末尾开头元素
//    arrayList.remove(arrayList.count-1)
//    print(arrayList)
//    arrayList.remove(arrayList.count-1)
//    print(arrayList)
//    arrayList.remove(arrayList.count-1)
//    print(arrayList)
//    arrayList.remove(arrayList.count-1)
//    print(arrayList)
    
//    arrayList.clear()
//    print(arrayList)
    
}


//MARK: - 链表测试用例
/// 链表测试用例
func testLinkList() {
    
//    let linkList = SingleLinkList<Int>()
//    let linkList = DoubleLinkList<Int>()
//    let data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
//    for obj in data {
//        linkList.add(obj)
//    }
//    print(linkList)
    
//    assert(linkList.size() == 13)
//    assert(linkList.indexOfElement(10) == 10)
//    assert(linkList.get(5) == 5)
//    assert(linkList.set(by: 0, element: 20) == 0)
//    assert(linkList.contains(50) == false)
//    assert(linkList.contains(20) == true)
//    assert(linkList.remove(0) == 20)
//    assert(linkList.remove(5) == 6)
//    assert(linkList.remove(linkList.size() - 1) == 12)
//    print(linkList)
    
//    linkList.add(by: 5, element: 50)
//    linkList.add(by: 0, element: 100)
//    print(linkList)
    

    
    // 约瑟夫问题
//    let linkList = CircleSingleLineList<Int>()
    let linkList = CircleDoubleLinkList<Int>()
    
    let data = [1, 2, 3, 4, 5, 6, 7, 8];
    for obj in data {
        linkList.add(obj)
    }
    print(linkList)

    linkList.reset()

    while !linkList.isEmpty() {
        linkList.next()
        linkList.next()
        linkList.removeCurrent()
        print(linkList)
    }
}


//MARK: - 二叉树测试用例
func printTree(tree: BSTree<Int>) {
    let log = InorderPrinter.printTree(tree)
    log.printIn()
}

/// 二叉树测试用例
func testBSTree() {
    
    let tree = BSTree<Int>()
    let data = [7, 4, 9, 2, 5, 8, 11]
    for e in data {
        tree.add(e)
    }
    printTree(tree: tree)
    
//    MJBinaryTrees.print(tree)
    
    //    tree.remove(8)
    //    printTree(tree: tree)
    //
    //    tree.remove(5)
    //    printTree(tree: tree)
    
    
//    print("----------")
    // 层序遍历（迭代）
//    tree.levelOrder { element in
//        print(element!)
//    }
    
//    // 前序遍历（迭代）
//    tree.preOrder { element in
//        print(element!)
//    }
//    print("----------")
//    tree.preOrderMorris { element in
//        print(element!)
//    }
//    print("----------")
    // 前序遍历（递归）
//    tree.preOrderCircle { element in
//        print(element!)
//    }
//    print("----------")
    
    
    // 中序遍历（迭代）
//    tree.inOrder { element in
//        print(element!)
//    }
//    print("----------")
//    tree.inOrderMorris { element in
//        print(element!)
//    }
//    // 中序遍历（递归）
//    tree.inOrderCircle { element in
//        print(element!)
//    }
    
    
    // 后序遍历（迭代）
    tree.postOrder { element in
        print(element!)
    }
    print("----------")
//    // 后序遍历（递归）
    tree.postOrderCircle { element in
        print(element!)
    }

    
}

//MARK: - AVL树测试用例
func testAVLTree() {
    
    let tree = AVLTree<Int>()
    let data = [2, 98, 100, 84, 7, 42, 20, 63, 53, 95, 91, 28, 19, 75, 59, 99, 29, 86]
    for e in data {
        tree.add(e)
    }
    printTree(tree: tree)
//    MJBinaryTrees.print(tree)
    
    tree.remove(20)
    printTree(tree: tree)
    
    tree.remove(82)
    printTree(tree: tree)
}

//MARK: - 红黑树测试用例
func testRBTree() {

    let tree = RBTree<Int>()
    let data = [55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50]
//    let data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
//    let data = [0, 1, 2]
    for e in data {
        tree.add(e)
    }
    printTree(tree: tree)
//    MJBinaryTrees.print(tree)
    
//    tree.remove(20)
//    printTree(tree: tree)
//
//    tree.remove(82)
//    printTree(tree: tree)
}


//MARK: - TreeMap测试用例
func printMap(map: TreeMap<Int, Int>) {
    let log = InorderPrinter.printTree(map)
    log.printIn()
}

func testTreeMap() {
    
    let treeMap = TreeMap<Int, Int>()
    let keys = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    let vals = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    
    for i in 0..<keys.count {
        treeMap.put(key: keys[i], val: vals[i])
    }
    
    printMap(map: treeMap)
    
    treeMap.remove(key: 9)
    printMap(map: treeMap)
    
    treeMap.traversal { key, val in
        print("\(key):\(val)")
    }
}

//MARK: - HashMap测试用例
func testHashMap() {
    
    let hashMap = HashMap<Int, Int>()
    
    hashMap.put(key: 11, val: 11)
    hashMap.put(key: 22, val: 22)
    hashMap.put(key: 33, val: 33)
    
    let keys = [55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50];
    let vals = [55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50];
    for i in 0..<keys.count {
        hashMap.put(key: keys[i], val: vals[i])
    }
    
    assert(hashMap.containsKey(key: 11))
    assert(hashMap.containsValue(val: 33))
    
    hashMap.remove(key: 33)
    print("删除33")
    
    hashMap.traversal { key, value in
        print("\(key!):\(value!)")
    }
}


//MARK: - Heap测试用例
func printHeap(_ heap: BinaryHeap<Int>) {
    let log = InorderPrinter.printTree(heap)
    log.printIn()
}

func testBinaryHeap() {
    
    let keys = [68, 72, 43, 50, 38, 10, 90, 65];
    let heap = BinaryHeap(vals: keys)
    
    printHeap(heap)
    
    heap.remove()
    printHeap(heap)
    
    heap.replace(val: 30)
    printHeap(heap)
    
}


//MARK: - 排序算法
func testSort() {
    
    let data = [51, 30, 39, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
    
//    let data = [51, 30, 39, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 100, 101, 102, 103, 104, 105]
    
    
//    let sort = BubbleSort1<Int>()
//    let sort = BubbleSort2<Int>()
//    let sort = BubbleSort3<Int>()
//    let sort = SelectionSort<Int>()
//    let sort = HeapSort<Int>()
//    let sort = InsertionSort1<Int>()
//    let sort = InsertionSort2<Int>()
//    let sort = InsertionSort3<Int>()
//    let sort = InsertionSort4<Int>()
//    let sort = BinarySearch<Int>()
//    let sort = MergeSort<Int>()
    let sort = QuickSort<Int>()
//    let sort = ShellSort<Int>()
//    let sort = CountingSort<Int>()
//    let sort = RadixSort<Int>()
//    let sort = BucketSort()
    
    
    let array = sort.sorted(by: data)
    print(array)
}


//MARK: - 图-测试用例
func testGraph() {
    
    let graph = ListGraph<String, Int>()
//    graph.addEdge(from: "V1", to: "V0", weight: 9)
////    graph.addEdge(from: "V1", to: "V0", weight: 8)
//    graph.addEdge(from: "V1", to: "V2", weight: 3)
//    graph.addEdge(from: "V2", to: "V0", weight: 2)
//    graph.addEdge(from: "V2", to: "V3", weight: 5)
//    graph.addEdge(from: "V0", to: "V4", weight: 6)
//    graph.addEdge(from: "V3", to: "V4", weight: 1)
//
//    graph.printListGraph()
    
//    graph.removeEdge(from: "V1", to: "V0")
//    graph.printListGraph()

//    graph.removeVertex(val: "V0")
//    graph.printListGraph()
    
    // BFS
//    graph.depthFirstSearch(begin: "V1") { val in
//        print("\(val)")
//    }
    
    // DFS1
//    graph.depthFirstSearch(begin: "V1") { val in
//        print("\(val)")
//    }

    // DFS2
//    graph.depthFirstSearchCircle(begin: "V1") { val in
//        print("\(val)")
//    }
    
    /// 测试拓扑排序
//    GraphTest<Int>.topSortTest(GraphData.TOPO)
    

    /// 最小生成树问题 - 测试Prim算法
//    GraphTest<Int>.mstPrim(GraphData.MST_01)
    /// 最小生成树问题 - 测试Kruskal算法
//    GraphTest<Int>.mstKruskal(GraphData.MST_01)
    
    
    /// 测试最短路径问题0
//    GraphTest<String>.shortPath();
    /// 测试最短路径问题1 - Dijkstra算法
    GraphTest<String>.dijkstraShortPath();
    /// 测试最短路径问题2 - BellmanFords算法
//    GraphTest<String>.bellmanFordShortPath();
    /// 测试最短路径问题3- floyd算法
//    GraphTest<String>.floydShortPath();
}

//MARK: - 算法思想-测试用例
func testSuanFa() {
    
    // 求和问题1
    assert(Recursion.sum1(n: 1) == 1)
    assert(Recursion.sum1(n: 2) == 3)
    assert(Recursion.sum1(n: 3) == 6)
    assert(Recursion.sum1(n: 4) == 10)
    
    // 求和问题2
    assert(Recursion.sum2(n: 1) == 1)
    assert(Recursion.sum2(n: 2) == 3)
    assert(Recursion.sum2(n: 3) == 6)
    assert(Recursion.sum2(n: 4) == 10)
    
    // 斐波那契数列问题1
    assert(Recursion.fib1(n: 1) == 1)
    assert(Recursion.fib1(n: 2) == 1)
    assert(Recursion.fib1(n: 3) == 2)
    assert(Recursion.fib1(n: 4) == 3)
    assert(Recursion.fib1(n: 5) == 5)
    assert(Recursion.fib1(n: 6) == 8)
    
    // 斐波那契数列问题2
    assert(Recursion.fib2(n: 1) == 1)
    assert(Recursion.fib2(n: 2) == 1)
    assert(Recursion.fib2(n: 3) == 2)
    assert(Recursion.fib2(n: 4) == 3)
    assert(Recursion.fib2(n: 5) == 5)
    assert(Recursion.fib2(n: 6) == 8)
    
    // 跳台阶问题1
    assert(Recursion.step1(n: 1) == 1)
    assert(Recursion.step1(n: 2) == 2)
    assert(Recursion.step1(n: 3) == 3)
    assert(Recursion.step1(n: 4) == 5)
    
    // 跳台阶问题2
    assert(Recursion.step2(n: 1) == 1)
    assert(Recursion.step2(n: 2) == 2)
    assert(Recursion.step2(n: 3) == 3)
    assert(Recursion.step2(n: 4) == 5)
    
    // 汉诺塔问题
//    Recursion.hanoi(n: 3, a: "1", b: "2", c: "3")
    
    // n皇后问题
    let recall = RecallFirst()
    recall.quaceQueens(8)
}



//MARK: - 字符串-测试用例
func testSequence() {
    
    let text = "Hello Word!"
    
    let sequence = Sequence()
    assert(sequence.indexOf1(text: text, pattern: "or") == 7)
    assert(sequence.indexOf1(text: text, pattern: "o") == 4)
    assert(sequence.indexOf2(text: text, pattern: "or") == 7)
    assert(sequence.indexOf2(text: text, pattern: "o") == 4)
}


//MARK: - 测试入口

//testArrayList()
//testLinkList()

//testBSTree()
//testAVLTree()
//testRBTree()

//testTreeMap()
//testHashMap()

//testBinaryHeap()

testSort()

//testGraph()

//testSuanFa()

//testSequence()

//var ans = [1,2,3];
//print(ans.reverse())

//let s = Solution()
//let list = s.trap([4,2,0,3,2,5])
//print(list)

//let s = Solution()
//let x = s.reverseStr("abcdefg", 2)
//let x = s.reverseWords("the sky is blue")
//print(x)



