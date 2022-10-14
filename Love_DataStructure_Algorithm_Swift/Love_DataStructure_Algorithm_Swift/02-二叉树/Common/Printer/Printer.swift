//
//  Printer.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/19.
//

import Cocoa

class Printer {
    
    var tree: BinaryTreeProtocol?
    
    func printTree(_ tree: BinaryTreeProtocol) -> Printer {
        let print = Printer()
        print.tree = tree
        return print
    }
    
    func printIn() {
        printOut()
        print("\n")
    }
    
    func printOut() {
        print(printString()?.utf8 ?? "")
    }
    
    func printString() -> String? {
        return nil
    }
}
