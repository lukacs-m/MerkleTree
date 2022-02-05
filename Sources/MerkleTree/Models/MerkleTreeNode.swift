//
//  MerkleTreeNode.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

import Foundation

/// Implementation of a `TreeNode` as a merkle tree node
final public class MerkleTreeNode: TreeNode {
    public var hash: String
    public var left: TreeNode?
    public var right: TreeNode?

    public init(stringData: String) {
        self.hash = stringData.sha256
    }
    
    public init(hash: String, left: TreeNode, right: TreeNode) {
        self.hash = hash
        self.left = left
        self.right = right
    }
}
