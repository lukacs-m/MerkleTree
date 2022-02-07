//
//  MerkleTreeProcessing.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

/// Base generic protocol for a tree implementation
public protocol TreeProcessing {
    var height: Int { get }
    var root: TreeNode { get }
    func level(at index: Int) -> [String]
}
