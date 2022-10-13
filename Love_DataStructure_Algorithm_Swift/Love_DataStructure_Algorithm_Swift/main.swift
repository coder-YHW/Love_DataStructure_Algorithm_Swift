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


//MARK: - 测试入口
testArrayList()

//testLinkList()
