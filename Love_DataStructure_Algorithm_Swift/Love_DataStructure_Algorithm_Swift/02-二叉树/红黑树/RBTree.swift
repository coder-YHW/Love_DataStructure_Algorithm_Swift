//
//  RBTree.swift
//  Love_DataStructure_Algorithm_Swift
//
//  Created by 余衡武 on 2022/10/7.
//

import Cocoa

/// 红黑树 - 4阶B树 - （2-3-4树）
class RBTree<E: Comparable>: BBSTree<E> {
    
    //MARK: override
    /// 重写node构造方法
    override func createNode(element: E?, parent: TreeNode<E>?) -> TreeNode<E> {
        return RBNode(element: element, parent: parent as? RBNode<E>)
    }
    
    /// 添加node之后的调整节点
    override func afterAdd(_ node: TreeNode<E>) {
        
        guard let parent = node.parent else {
            // 1、添加的是根节点,或者上溢到达了根节点
            // 1.1、将自己染黑就行了
            black(node: node)
            return
        }

        // 红黑红、黑红、红黑、黑 - 总共12种情况
        // 2、如果父节点是黑色,直接返回 - 新添加的节点默认是红色的
        if isBlack(node: parent) {
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
                afterAdd(node)
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
    
    /// 删除node之后的调整节点
    override func afterRemove(_ node: TreeNode<E>) {
        
        // 1、如果删除的节点是红色 直接删除-不做任何调整 （合并到下面去判断）
        // if ([self isRed:node]) return; // 直接删除-不做任何调整

        /*1、如果删除的节点是红色 直接删除-不做任何调整
         *2、如果删除的黑色节点有2个Red子节点，会用前驱或者后继节点去替代删除（不用考虑这种情况）
         *
         *当删除的节点度为1时，afterRemove传进来的不是node，而是replcaeNode（红黑树要求 不影响AVL树）
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
           
            if isRed(node: sibling) == true { // 5.1.1、兄弟节点是红色 -（转成兄弟节点是黑色情况再处理）
                black(node: sibling)
                red(node: parent)
                rotateLeft(parent)
  
                // 更换兄弟
                sibling = parent.right;
            }

            // 5.1.2、兄弟节点必然是黑色
            if isBlack(node: sibling?.left) && isBlack(node: sibling?.right) {
                // 5.1.2.1、兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
                let parentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                
                if parentBlack { // 5.1.2.2、如果parent为Black，会导致parent下溢
                    afterRemove(parent)
                }
                
            } else { // 5.1.2.3、兄弟节点至少有一个红色子节点,向兄弟节点借元素
                // 兄弟节点的左边是黑色,兄弟要先旋转
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
            
            if isRed(node: sibling) { // 5.2.1、兄弟节点是红色 -（转成兄弟节点是黑色情况再处理）
                black(node: sibling)
                red(node: parent)
                rotateRight(parent)

                // 更换兄弟
                sibling = parent.left;
            }

            // 5.2.2、兄弟节点必然是黑色
            if isBlack(node: sibling?.left) && isBlack(node: sibling?.right) {
                // 3.2.2.1、兄弟节点没有一个红色子节点,父节点要向下跟兄弟节点合并（下溢）
                let parentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                
                if parentBlack { // 5.2.2.2、如果parent为Black，会导致parent下溢
                    afterRemove(parent)
                }

            } else { // 5.2.2.3、兄弟节点至少有一个红色子节点,向兄弟节点借元素
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


//MARK:  - 染色
extension RBTree {
    
    /**给红黑树节点染色**/
    @discardableResult
    fileprivate func color(node: TreeNode<E>?, color: Bool) -> TreeNode<E>? {
        
        if let node {
            (node as! RBNode).isRed = color
            return node
        }else {
            return nil
        }
    }
    
    /**将红黑树节点染成红色**/
    @discardableResult
    fileprivate func red(node: TreeNode<E>?) -> TreeNode<E>? {
        return color(node: node, color: true)
    }
    
    /**将红黑树节点染成黑色**/
    @discardableResult
    fileprivate func black(node: TreeNode<E>?) -> TreeNode<E>? {
        return color(node: node, color: false)
    }
    
    /**返回红黑树节点色值**/
    fileprivate func colorOf(node: TreeNode<E>?) -> Bool {
        if let node {
            return (node as! RBNode).isRed
        }else {
            return false
        }
    }
    
    /**红黑树节点是否是红色**/
    fileprivate func isRed(node: TreeNode<E>?) -> Bool {
        return colorOf(node: node) == true
    }
    
    /**红黑树节点是否是黑色**/
    fileprivate func isBlack(node: TreeNode<E>?) -> Bool {
        return colorOf(node: node) == false
    }
    
}


/**
 * 红黑树必须满足以下5个性质
 * 1、所有节点不是Red，就是Black
 * 2、根节点是Black
 * 3、叶子结点（外部节点、空节点）都是Black
 * 4、Red节点的子节点都是Black，Red节点的父节点都是Black
 *   也就是说从根节点到叶子结点的所有路径上不能有2个连续的Red节点
 * 5、从任一节点到叶子结点的所有路径都包含相同数目的Black节点
 */


/**
 * 红黑树既是一种自平衡的二叉搜索树，又等价于4阶B树 （2-3-4树）
 * 1、B树中，新元素必定是添加到叶子结点中
 * 2、4阶B树所有节点的元素个数x都符合 (1<= x <=3)
 * 3、建议新添加的节点默认为红色节点，这样能让红黑树性质尽快满足
 *  （红黑树性质1、2、3、5都满足，性质4不一定满足）
 */




