//
//  TreeNode.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

/// Base Generic information for a tree hash node
public protocol TreeNode {
    var hash: String { get }
    var left: TreeNode? { get }
    var right: TreeNode? { get }
}
