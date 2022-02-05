//
//  MerkleTreeCreating.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

public protocol MerkleTreeCreating {
    func createMerkleTree(with stringData: [String]) throws -> TreeProcessing
}
