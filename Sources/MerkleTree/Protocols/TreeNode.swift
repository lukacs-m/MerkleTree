//
//  TreeNode.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

public protocol TreeNode {
    var hash: String { get }
    var left: TreeNode? { get }
    var right: TreeNode? { get }
}
