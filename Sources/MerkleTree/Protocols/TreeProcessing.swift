//
//  MerkleTreeProcessing.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

public protocol TreeProcessing {
    var height: Double { get }
    var root: TreeNode { get }
    func level(at index: Int) -> [String]
}
