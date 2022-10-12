//
//  Enum.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/11.
//

import Cocoa

/// 错误类型
enum SomeError : Error , CaseIterable { // Error协议,CaseIterable协议
    
    case illegalArg(msg: String) /// 参数非法
    case outOfBounds(size: Int, index: Int) ///  索引越界
    
    static var allCases: [SomeError] { // 有关联值-要自己实现allCases
        return [.illegalArg(msg: "参数非法"), .outOfBounds(size: 3, index: 5)]
    }
}




/// 枚举一 - 全部case数组：allCases
enum DirectionType : CaseIterable {// 如果枚举没有关联值-编译器支持自动合成allCases
    case north,south,east,weat
}

/// 枚举二 - 原始值：rawValue
enum DirectionType1 : String , CaseIterable {
    case north = "north"
    case south = "south"
    case east = "east"
    case weat = "weat"
}

/// 枚举三- 隐式原始值 - String
enum DirectionType2 : String , CaseIterable {
    case north,south,east,weat
}

/// 枚举四- 隐式原始值 - Int
enum DirectionType3 : Int , CaseIterable {
    case north,south,east,weat
}

/// 枚举五 - 关联值：Associated Value
enum Score {
    case point(Int)
    case grade(Character)
}
