//
//  BBSTree.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

/// 平衡二叉搜索树 - 旋转操作
class BBSTree<E: Comparable>: BSTree<E> {
    
    //MARK: - 左旋转
    /// 左旋转
    func rotateLeft(_ grand: TreeNode<E>) {
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
    func rotateRight(_ grand: TreeNode<E>) {
        
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
    func afterRotate(_ grand: TreeNode<E>, parent: TreeNode<E>, child: TreeNode<E>?) {
        
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
    
    //MARK: - 统一旋转
    /// 平衡旋转 - - 旋转之后记得更新高度 - 子类重写
    func rotate(r: TreeNode<E>,
                a: TreeNode<E>?, b: TreeNode<E>?, c: TreeNode<E>?,
                d: TreeNode<E>,
                e: TreeNode<E>?, f: TreeNode<E>?, g: TreeNode<E>?) {
        
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


