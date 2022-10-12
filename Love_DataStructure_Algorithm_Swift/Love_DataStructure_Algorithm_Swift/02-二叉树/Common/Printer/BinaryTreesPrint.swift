//
//  BinaryTreesPrint.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/20.
//

import Cocoa

class BinaryTreesPrint {

    static func println(_ tree: BinaryTreeProtocol) {
        let log = InorderPrinter.printTree(tree)
        log.printIn()
    }
}
