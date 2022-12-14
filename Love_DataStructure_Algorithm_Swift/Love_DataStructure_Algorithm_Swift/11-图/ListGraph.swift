//
//  ListGraph.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/22.
//

import Cocoa

class ListGraph<V: Comparable & Hashable, E: Comparable & Hashable>: Graph<V, E> {

    //MARK: - 属性
    fileprivate var vertexs = HashMap<V, Vertex<V, E>>()
    fileprivate var edges = HashSet<Edge<V, E>>()
    
    
    //MARK: - override
    /// 边的个数
    override func edgesSize() -> Int {
        return edges.size()
    }
    
    /// 顶点个数
    override func vertexsSize() -> Int {
        return vertexs.count()
    }
    
    //MARK: 添加删除
    /// 添加顶点
    override func addVertex(val: V) {
        if vertexs.containsKey(key: val) { return }
        let vertex = Vertex<V, E>(val: val)
        vertexs.put(key: val, val: vertex)
    }
    
    /// 添加边
    override func addEdge(from: V, to: V) {
        addEdge(from: from, to: to, weight: nil)
    }
    
    /// 添加边(带权重)
    override func addEdge(from: V, to: V, weight: Double?) {
        
        // 1、fromVertex是否存在
        var fromVertex = vertexs.get(key: from)
        if fromVertex == nil {
            fromVertex = Vertex(val: from)
            vertexs.put(key: from, val: fromVertex)
        }
        
        // 2、toVertex是否存在
        var toVertex = vertexs.get(key: to)
        if toVertex == nil {
            toVertex = Vertex(val: to)
            vertexs.put(key: to, val: toVertex)
        }
        
        // 3、Edge是否存在 （Edge不存在 直接添加新edge）
        var edge = Edge(from: fromVertex, to: toVertex)
        edge.weight = weight
        
        // 3.1 Edge存在 先删除旧edge 再添加新edge - 3个HashSet都要删
        if  fromVertex!.outEdges.contains(edge) {
            fromVertex!.outEdges.remove(val: edge)
            toVertex!.inEdges.remove(val: edge)
            edges.remove(val: edge)
        }
        
        // 3.2 添加新edge - 3个HashSet都要加
        fromVertex!.outEdges.add(val: edge)
        toVertex!.inEdges.add(val: edge)
        edges.add(val: edge)
    }
    
    /// 删除顶点
    override func removeVertex(val: V) {

        // 0、顶点不存在
        guard let vertex = vertexs.get(key: val) else { return }

        // 1、删除inEdges - 不能一边遍历的同时又删除元素，可以用enumerate()➕reversed()
        let inEdgesArray = vertex.inEdges.allElements()
        for (i, _) in inEdgesArray.enumerated().reversed() {
            let edge = inEdgesArray[i]
            removeEdge(from: edge.from?.value, to: edge.to?.value)
        }
        
        // 2、删除outEdges - 不能一边遍历的同时又删除元素，可以用enumerate()➕reversed()
        let outEdgesArray = vertex.outEdges.allElements()
        for (i, _) in outEdgesArray.enumerated().reversed() {
            let edge = outEdgesArray[i]
            removeEdge(from: edge.from?.value, to: edge.to?.value)
        }
    }
    
    /// 删除边
    override func removeEdge(from: V?, to: V?) {
        guard let from = from, let to = to else { return }
        
        // 1、fromVertex不存在
        guard let fromVertex = vertexs.get(key: from) else {
            return
        }
        
        // 2、toVertex不存在
        guard let toVertex = vertexs.get(key: to) else {
            return
        }
        
        // 3、Edge是否存在
        let edge = Edge(from: fromVertex, to: toVertex)
        
        // 3.1、Edge存在才删除 - - 3个HashSet都要删
        if fromVertex.outEdges.contains(edge) {
            fromVertex.outEdges.remove(val: edge)
            toVertex.inEdges.remove(val: edge)
            edges.remove(val: edge)
        }
    }
    
    //MARK: - 图的遍历 - BFS - 层序遍历-队列实现
    /// 广度优先搜索(Breadth First Search)
    override func breadthFirstSearch(begin: V?, visitor: ((V) -> ())) {
        // 0、非空检测
        guard let key = begin else { return }
        guard let beginVertex = vertexs.get(key: key) else { return }
        
        // 1.1、创建一个hashSet 保存已经遍历过的顶点
        let vertexSet = HashSet<Vertex<V, E>>()
        // 1.2、创建一个SingleQueue beginVertex入队
        let queue = SingleQueue<Vertex<V, E>>()
        queue.enQueue(beginVertex)
        vertexSet.add(val: beginVertex) // 注意：这句代码位置
        
        while !queue.isEmpty() {
            
            // 2、出队
            if let vertex = queue.deQueue() {
                if let val = vertex.value {
                    visitor(val)
                }
                
                // 3、遍历inEdges 将边.to中 所有非重复顶点入队
                for edge in vertex.outEdges.allElements() {
                    if let toVertex = edge.to {
                        if vertexSet.contains(toVertex) { continue }
                        queue.enQueue(toVertex) // 非重复顶点入队
                        vertexSet.add(val: toVertex) // 注意：这句代码位置
                    }
                }
            }
        }
    }
    
    //MARK: 图的遍历 - DFS - 前序遍历-栈实现
    /// 深度优先搜索(Depth First Search)[非递归]
    override func depthFirstSearch(begin: V?, visitor: ((V) -> ())) {
        // 0、非空检测
        guard let key = begin else { return }
        guard let beginVertex = vertexs.get(key: key) else { return }
        
        // 1.1、创建一个hashSet 保存已经遍历过的顶点
        let vertexSet = HashSet<Vertex<V, E>>()
        // 1.2、创建一个Statck beginVertex入栈
        let statck = Statck<Vertex<V, E>>()
        statck.push(beginVertex)
        vertexSet.add(val: beginVertex)

        while !statck.isEmpty() {
            
            // 2、出栈
            if let vertex = statck.pop() {
                // 遍历器
                if let val = vertex.value {
                    visitor(val)
                }
                
                // 3、遍历inEdges 将边.to中 所有非重复顶点入队
                for edge in vertex.outEdges.allElements() {
                    if let toVertex = edge.to {
                        if vertexSet.contains(toVertex) { continue }
                        statck.push(toVertex) // 非重复顶点入栈
                        vertexSet.add(val: toVertex) // 注意：这句代码位置
                    }
                }
            }
        }
    }
    
    //MARK: 图的遍历 - DFS - 前序遍历-递归实现
    /// 深度优先搜索(Depth First Search)[递归]
    override func depthFirstSearchCircle(begin: V?, visitor: ((V) -> ())) {
        guard let key = begin else { return }
        guard let beginVertex = vertexs.get(key: key) else { return }
        
        let vertexSet = HashSet<Vertex<V, E>>()
        depthSearch(beginVertex, set: vertexSet, visitor: visitor)
    }
    
    /// 深度优先搜索, 递归
    fileprivate func depthSearch(_ vertex: Vertex<V, E>, set: HashSet<Vertex<V, E>>, visitor: ((V) -> ())) {
        // 遍历器
        if let val = vertex.value {
            visitor(val)
        }
        set.add(val: vertex) // 注意：这句代码位置
        
        // 3.2、遍历inEdges 将边.to 递归调用
        for edge in vertex.outEdges.allElements() {
            
            if let toVertex = edge.to {
                if set.contains(toVertex) { continue }
                depthSearch(toVertex, set: set, visitor: visitor) // 非重复顶点 - 递归调用
            }
        }
    }
    
    //MARK: - AOV网问题 - 拓扑排序（卡恩算法）
    /*
     * 拓扑排序
     * AOV网的遍历, 把AOV的所有活动排成一个序列
     */
    override func topologicalSort() -> [V] {
        
        // 0、初始化容器
        var valueArray = [V]() // 数组装排序好之后顶点的value
        let degreeMap = HashMap<Vertex<V, E>, Int>()  // 保存入度不为o的顶点 维护这张HashMap
        let queue = SingleQueue<Vertex<V, E>>() // 队列保存入度为0的顶点
        
        // 1、遍历所有顶点 找出入度为0的顶点 记录入度不为0的顶点
        vertexs.traversal { val, vertex in
            // 避免重复计算 用变量保存
            if let count = vertex?.inEdges.size() {
                if count == 0 { // 1.1、找出入度为0的顶点 入队queue
                    queue.enQueue(vertex)
                } else { // 1.2、记录入度不为0的顶点 存入degreeMap
                    degreeMap.put(key: vertex, val: count)
                }
            }
        }
        
        // 2、顶点一个个出队 把value加入数组 degreeMap中度--
        while !queue.isEmpty() {
            let vertex = queue.deQueue() // 2.1、顶点一个个出队
            if let val = vertex?.value {
                valueArray.append(val) // 2.2、把value加入数组 相当于删除这个顶点
            }
            
            // 3、遍历vertex.outEdges所有to顶点 将入度为1的顶点入队 其他顶点度--
            // 3.1、注意：一定要从我们自己维护的degreeMap里取度 不要从toVertex.inEdges.size里取
            vertex?.outEdges.allElements().forEach({ edge in
                if let vertex = edge.to, let count = degreeMap.get(key: vertex) { // 从我们自己维护的degreeMap里取度
                    if count == 1 { // 3.1、将入度为1的顶点入队
                        queue.enQueue(vertex)
                    } else { // 3.2、其他顶点的入度-- 更新degreeMap
                        degreeMap.put(key: vertex, val: count - 1)
                    }
                }
            })
        }
        
        return valueArray
    }
    
    //MARK:  AOE网问题
    
    //MARK: - 最小生成树问题（光缆铺设）- Prim算法（普里姆算法-切分定理）
    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * prim算法方式
     */
    override func mstPrim() -> HashSet<Edge<V, E>>? {
        
        // 1、从图所有顶点中 随机取一个顶点
        let verArr = vertexs.allValues()
        guard let vertex = verArr.first else { return nil }
        
        // 返回给外界的边Set
        let edgeInfos = HashSet<Edge<V, E>>()
        // 已经切分好或者将要切分的顶点Set
        let addedVertexs = HashSet<Vertex<V, E>>()
        // 2.1、切分操作1 -  往addedVertexs里添加顶点（）
        addedVertexs.add(val: vertex)
        // 2.2、切分操作2 - 创建一个最小堆 选出outEdges里权重最小的边
        let minHeap = MinHeap(vals: vertex.outEdges.allElements())
        
        // 堆不为空 && 还有顶点未切分
        let count = vertexs.count();   // 计算数量耗时 放在条件前计算 只要计算一次就好
        while !minHeap.isEmpty() && addedVertexs.size() < count {
            
            // 3、选出权重最小的那条边edge
            guard let topEdge = minHeap.remove() else { continue }
            
            // 4、重复切分操作
            if let toVertex = topEdge.to {
                if addedVertexs.contains(toVertex) {
                    continue // 已经切分过的顶点
                }
                
                // 4.1 重复切分操作1 - edge.to中未切分过的顶点加入addedVertexs
                addedVertexs.add(val: toVertex)
                // 5、返回给外界的边Set
                edgeInfos.add(val: topEdge)
            }
            
            // 4.2、重复切分操作2 - 最小堆 选出outEdges里权重最小的边
            if let edges = topEdge.to?.outEdges.allElements() {
                minHeap.addAll(vals: edges)
            }
        }
        
        return edgeInfos
    }
    
    //MARK: 最小生成树问题（光缆铺设）- Kruskal算法(克鲁斯卡尔算法)
    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * Kruskal算法方式
     */
    override func mstKruskal() -> HashSet<Edge<V, E>>? {
        // 1、 (顶点:n -> 边：n-1)
        let edgeCount = vertexs.count() - 1
        if edgeCount < 0 { return nil }
        
        // 2、返回给外界的边Set
        let edgeInfos = HashSet<Edge<V, E>>()
        
        // 3、创建一个最小堆 原地建堆
        let minHeap = MinHeap(vals: edges.allElements())
        
        // 4、创建一个并查集 为所有顶点创建集合
        let uf = GenericUnionFind<Vertex<V, E>>()
        vertexs.allValues().forEach { vertex in
            uf.makeSet(vertex)
        }
        
        // 5、循环寻找权重最小 且 不会够成循环的边
        while !minHeap.isEmpty() && edgeInfos.size() < edgeCount {
            // 5.1、出堆 - 拿出堆顶元素（权重最小的边）
            if let edge = minHeap.remove() {
                // 5.2、查看边2顶点是否在同一集合内
                if uf.isSame(v1: edge.from, v2: edge.to) {
                    // 5.3 在同一集合内 再添加 会构成环
                    continue
                }else {
                    // 5.4 不在同一集合内 选出这条边
                    edgeInfos.add(val: edge)
                    // 5.5 合并这两个顶点
                    uf.union(v1: edge.from, v2: edge.to)
                }
            }
        }
        return edgeInfos
    }
    
    //MARK: - 最短路径问题 - 简单版 (拽石头-松弛操作）
    /*
     * 有向图、无向图都支持
     * 从某一点出发的最短路径(权值最小)
     * 返回权值
     * 未优化代码
     */
    override func shortestPath(_ begin: V) -> HashMap<V, Double>? {
        // 0、取出开始值对应的顶点 空值校验
        guard let beginVertex = vertexs.get(key: begin) else { return nil }
        
        // 1、等待被选择的路径s (key:toVertex value:weight) 从起点到其他点的路径信息
        let waitPaths = HashMap<Vertex<V, E>, Double>()
        beginVertex.outEdges.allElements().forEach { edge in
            if let toVertex = edge.to, let weight = edge.weight {
                waitPaths.put(key: toVertex, val: weight)
            }
        }
        
        // 2、已经确定的最小路径s 返回给外界  (key:vertex.value  value:weight)
        let finishPaths = HashMap<V, Double>()
        // 5.1、原点首先加入 表示已处理
        finishPaths.put(key: begin, val: 0)
        
        // 3、筛选出最短路径 - 循环操作
        while !waitPaths.isEmpty() {
            /// 3.0、根据边信息, 筛选权值最小的路径
            let minData = minWeightPath(waitPaths)
            
            if let minVertex = minData.0 {
                // 3.1、将最短路径存入finishPaths
                finishPaths.put(key: minVertex.value, val: minData.1)
                
                // 3.2、将最短路径从waitPaths删除
                waitPaths.remove(key: minVertex)
                
                // 4、对minVertex.outEdges进行松弛操作 更新waitPaths路径
                for edge in minVertex.outEdges.allElements() {
                    
                    // 4.1、去除重复操作 - 无向路径可能会往回重复寻找
                    if let key = edge.to?.value {
                        if finishPaths.containsKey(key: key) {
                            continue
                        }
                        
                        // 4.2、原点到toVertex的新权重:edge.weight + minData.1
                        let newWeight = minData.1 + (edge.weight ?? 0)
                        // 4.3、以前没有到原点的旧路径 oldWeight为nil
                        guard let oldWeight = waitPaths.get(key: minVertex) else {
                            // 4.4 oldWeight为nil 更新松弛之后的waitPaths
                            waitPaths.put(key: edge.to, val: newWeight)
                            continue
                        }
                        
                        // 4.5、以前有到原点的旧路径旧路径 且 newWeight < oldWeight
                        if oldWeight > newWeight {
                            // 更新松弛之后的waitPaths
                            waitPaths.put(key: edge.to, val: newWeight)
                        }
                    }
                }
            }
        }
        
        // 5.2、原点最后要删除
        finishPaths.remove(key: begin)
        return finishPaths
    }
    
    /// 根据权值, 筛选权值最小的路径
    fileprivate func minWeightPath(_ paths: HashMap<Vertex<V, E>, Double>) -> (Vertex<V, E>?, Double) {
        var verterx: Vertex<V, E>?
        var weight: Double = 0
        
        paths.allKeys().forEach { ver in
            if verterx == nil {
                verterx = ver
                weight = paths.get(key: ver) ?? 0
            } else {
                let tmpWeight = paths.get(key: ver) ?? 0
                if weight > tmpWeight {
                    verterx = ver
                    weight = tmpWeight
                }
            }
        }
        
        return (verterx, weight)
    }

    
    //MARK: 单源最短路径算法1 - Dijkstra(迪杰斯特拉)
    /*
     * Dijkstra: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 不支持有负权边
     * 松弛操作：从起点开始 对新加入的顶点进行松弛操作
     */
    override func dijkstraShortPath(_ begin: V) -> HashMap<V, Path<V, E>>? {
        // 0、取出开始值对应的顶点 空值校验
        guard let beginVertex = vertexs.get(key: begin) else { return nil }
        
        // 1、等待被选择的路径s (key:toVertex value:Path) 从起点到其他点的路径信息
        // 从起点开始做松弛操作
        let waitPaths = HashMap<Vertex<V, E>, Path<V, E>>()
        waitPaths.put(key: beginVertex, val: Path())
        
        // 2、已经确定的最小路径s 返回给外界  (key:vertex.value  value:Path)
        let finishPaths = HashMap<V, Path<V, E>>()
        
        // 3、筛选出最短路径 - 循环操作
        while !waitPaths.isEmpty() {
            /// 3.0、根据边信息, 筛选权值最小的路径
            let minData = minPathInfo(waitPaths)
            
            if let minVertex = minData.0, let minPath = minData.1 {
                // 3.1、将最短路径存入finishPaths
                finishPaths.put(key: minVertex.value, val: minPath)
                
                // 3.2、将最短路径从waitPaths删除
                waitPaths.remove(key: minVertex)
                    
                // 4、对minVertex.outEdges进行松弛操作 更新waitPaths路径
                for edge in minVertex.outEdges.allElements() {
                    /// 松弛操作封装一
                    relax(edge, minPath: minPath, finishPaths: finishPaths, waitPaths: waitPaths)
                }
            }
        }
        
        finishPaths.remove(key: begin)
        return finishPaths
    }
    
    /// 根据边信息, 筛选权值最小的路径 minVertex
    fileprivate func minPathInfo(_ paths: HashMap<Vertex<V, E>, Path<V, E>>) -> (Vertex<V, E>?, Path<V, E>?) {
        var verterx: Vertex<V, E>?
        var pathInfo: Path<V, E>?
        
        paths.allKeys().forEach { ver in
            if verterx == nil {
                verterx = ver
                pathInfo = paths.get(key: ver)
            } else {
                let path = paths.get(key: ver)
                if let w1 = pathInfo?.weight, let w2 = path?.weight {
                    if w1 > w2 {
                        verterx = ver
                        pathInfo = path
                    }
                } else {
                    verterx = ver
                    pathInfo = path
                }
            }
        }
        
        return (verterx, pathInfo)
    }
    
    /// 松弛操作封装一
    @discardableResult
    fileprivate func relax(_ edge: Edge<V, E>, minPath: Path<V, E>, finishPaths: HashMap<V, Path<V, E>>, waitPaths: HashMap<Vertex<V, E>, Path<V, E>>) -> Bool {
        
        // 4.0、松弛新节点
        guard let minVertex = edge.to else {
            return false
        }
        
        // 4.1、去除重复操作 - 无向路径可能会往回重复寻找
        if let toVal = edge.to?.value {
            if finishPaths.containsKey(key: toVal) {
                return false
            }
            
            // 4.2、原点到toVertex的新权重:edge.weight + minData.1
            let newWeight = minPath.weight + (edge.weight ?? 0)
            // 4.3、以前没有到原点的旧路径 oldWeight为nil
            var oldPath = waitPaths.get(key: minVertex)
            if oldPath == nil {
                oldPath = Path()
                waitPaths.put(key: edge.to, val: oldPath)
            } else if newWeight >= oldPath!.weight  {
                // 5.1、newWeight >= oldWeight 没有更新的必要
                return false
            }
            
            // 5.2、oldWeight为nil 或则 newWeight < oldWeight 更新权重weight
            oldPath?.weight = newWeight
            
            // 5.3、oldWeight为nil 或则 newWeight < oldWeight 更新路径信息edgeInfos
            oldPath?.edgeInfos.removeAll()
            oldPath?.edgeInfos.append(contentsOf: minPath.edgeInfos)
            oldPath?.edgeInfos.append(edge)
        }
        
        return true
    }
    
    //MARK: 单源最短路径算法2 - BellmanFord(贝尔曼-福特)
    /*
     * BellmanFord: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 支持有负权边
     * 支持检测是否有负权环
     * 支持检测是否有负权环 第V次还有权重更新 则有负权环
     * 对所有边进行V-1次松弛操作（V是节点数量），得到所有可能的最短路径
     */
    override func bellmanFordShortPath(_ begin: V) -> HashMap<V, Path<V, E>>? {
        guard vertexs.get(key: begin) != nil else { return nil }
        
        let finishPaths = HashMap<V, Path<V, E>>()
        finishPaths.put(key: begin, val: Path())
        
        // 对所有边进行V-1次松弛操作（V是节点数量），得到所有可能的最短路径
        let v = vertexs.count()
        for _ in 0..<v - 1 {
            for edge in edges.allElements() {
                if let fromVal = edge.from?.value {
                    guard let fromPath = finishPaths.get(key: fromVal) else {
                        // fromPath为nil 意味着以前没有记录 松弛失败 不需要处理
                        continue
                    }
                    relax(edge, fromPath: fromPath, paths: finishPaths)
                }
            }
        }
        
        // 对所有边进行第V次松弛操作（V是节点数量）如果还有权重更新 则有负权环
        for edge in edges.allElements() {
            if let fromVal = edge.from?.value {
                guard let fromPath = finishPaths.get(key: fromVal) else { continue }
                if relax(edge, fromPath: fromPath, paths: finishPaths) {
                    print("图中包含负权环")
                    return nil
                }
            }
        }
        
        finishPaths.remove(key: begin)
        return finishPaths
    }
    
    /// 松弛操作封装二
    @discardableResult
    fileprivate func relax(_ edge: Edge<V, E>, fromPath: Path<V, E>, paths: HashMap<V, Path<V, E>>) -> Bool {

        // 1、以前的最短路径 - 新增代码
        guard let toVal = edge.to?.value else {
            return false
        }
        
//        // 去除重复操作 - 无向路径可能会往回重复寻找
//        // bellmanFord算法不需要去重
//        if finishPaths.containsKey(key: toVal) {
//            continue
//        }
        // 2、fromPath为nil 意味着以前没有记录 松弛失败 不需要处理 (调用前已处理)

            
        // 3、原点到toVertex的新权重:edge.weight + minWeight
        // 3.1、newWeight
        let newWeight = fromPath.weight + (edge.weight ?? 0)
        // 3.2、oldWeight
        var oldPath = paths.get(key: toVal)

        if oldPath == nil {
            // 4.0、没有路径信息的 创建路径信息
            oldPath = Path()
            paths.put(key: toVal, val: oldPath)
        } else {
            if newWeight >= oldPath?.weight ?? 0 {
                // 4.1、newWeight >= oldWeight 没有更新的必要
                return false
            }
        }
        
        // 4.2、oldWeight为nil 或则 newWeight < oldWeight 更新权重weight
        oldPath?.weight = newWeight
        
        // 4.3、oldWeight为nil 或则 newWeight < oldWeight 更新路径信息edgeInfos
        oldPath?.edgeInfos.removeAll()
        oldPath?.edgeInfos.append(contentsOf: fromPath.edgeInfos)
        oldPath?.edgeInfos.append(edge)
        
        return true
    }
    
    //MARK: 多源最短路径算法 floydShortPath（弗洛伊德）
    /*
     * Floyd: 多源最短路径算法,用于计算任意两个顶点的最短路径
     * 支持有负权边
     * 时间复杂度: O(V^3)
     */
    override func floydShortPath() -> HashMap<V, HashMap<V, Path<V, E>>>? {
        // 1、最小路径Map 返回给外界  (key:val  value:HashMap)
        // 嵌套HashMap: HashMap<fromVal, HashMap<toValue, Path<V, E>>>()
        let finishPaths = HashMap<V, HashMap<V, Path<V, E>>>()
        
        // 2、将所有边加入finishPaths
        for edge in edges.allElements() {
            if let fromVal = edge.from?.value {
                var pathMap = finishPaths.get(key: fromVal)
                // 2.1、pathMap不存在 创建pathMap
                if pathMap == nil {
                    pathMap = HashMap()
                    // 注意（key：fromVal  value:pathMap）
                    finishPaths.put(key: fromVal, val: pathMap)
                }
                
                // 2.2、pathMap存在 - 创建路径信息 存入pathMap
                // 创建路径信息
                let pathInfo = Path<V, E>()
                pathInfo.edgeInfos.append(edge)
                // 注意给Path个初始权值
                pathInfo.weight = edge.weight ?? 0;
                // 注意（key：toValue  value:pathInfo）
                let toValue = edge.to?.value
                pathMap?.put(key: toValue, val: pathInfo)
            }
        }
        
        // 3、三层for循环 遍历allkeys 顺序不能乱
        vertexs.allKeys().forEach { v2 in // v2
            vertexs.allKeys().forEach { v1 in // v1
                vertexs.allKeys().forEach { v3 in // v3
                    // 异常情况处理
                    if v1 == v2 || v1 == v3 || v3 == v2 { return }
                    
                    // v1 -> v2
                    guard let path12 = getPathInfo(finishPaths, from: v1, to: v2) else {
                        return
                    }
                    // v2 -> v3
                    guard let path23 = getPathInfo(finishPaths, from: v2, to: v3) else {
                        return
                    }
                    // v1 -> v3
                    var path13 = getPathInfo(finishPaths, from: v1, to: v3)
                    
                    // 新路径权重 - newWeight
                    let newWeight = path12.weight + path23.weight
                    //  path13还不存在 创建path13
                    if path13 == nil {
                        path13 = Path()
                        let pathMap = finishPaths.get(key: v1)
                        pathMap?.put(key: v3, val: path13)
                    } else if let oldWeight = path13?.weight, newWeight >= oldWeight {
                        // 权重：path12 + path23 >= path13 无需更新权重
                        return
                    }
                    
                    // path13为nil 或者 权重：path12 + path23 < path13 更新权重weight
                    path13?.weight = newWeight
                    // path13为nil 或者 权重：path12 + path23 < path13 更新路径信息edgeInfos
                    path13?.edgeInfos.removeAll()
                    path13?.edgeInfos.append(contentsOf: path12.edgeInfos)
                    path13?.edgeInfos.append(contentsOf: path23.edgeInfos)
                }
            }
        }
        
        return finishPaths
    }
    
    /// 获取edge的路径信息
    fileprivate func getPathInfo(_ finishPaths: HashMap<V, HashMap<V, Path<V, E>>>, from: V, to: V) -> Path<V, E>? {
        let pathMap = finishPaths.get(key: from)
        return pathMap == nil ? nil : pathMap?.get(key: to)
    }
}


// MARK: - 打印
extension ListGraph {
    
    public func printListGraph() {
        
        for vertex in vertexs.allValues() {
            
            Swift.print("---------\(vertex)：打印开始-----------")
            
            vertex.inEdges.traversal { edge in
                Swift.print("inEdges ：\(edge)")
            }
            
            vertex.outEdges.traversal { edge in
                Swift.print("outEdges：\(edge)")
            }
            
            Swift.print("---------\(vertex)：打印结束-----------")
        }
        
        
        print("---------边打印开始-----------")
        edges.traversal { edge in
            print("\(edge)")
        }
        print("---------边打印结束-----------")
    }
    

}
