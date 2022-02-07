//
//  MerkleTree.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

/// A merkle tree implementing the `TreeProcessing` protocol
public struct MerkleTree: TreeProcessing {
    let treeGraph: [TreeNode]

    public let height: Int
    public var root: TreeNode {
        treeGraph.first!
    }
    
    init(treeGraph: [TreeNode], height: Int) {
        self.height = height
        self.treeGraph = treeGraph
    }

    public func level(at index: Int) -> [String] {
        guard index <= Int(height) else {
            return []
        }
        return getHashAt(index, treeNode: root)
    }
}

// MARK: - Utils

private extension MerkleTree {
    /// Enables us to fetch an array of the hash of elements at a certain deph in the tree
    /// - Parameters:
    ///   - index: The level of element hash we want to get back
    ///   - treeNode: The current tree node
    ///   - currentDepth: The current depth to compared to the index we want to fetch
    /// - Returns: An array containing the hashs of all the elements a the selected index
    func getHashAt(_ index: Int, treeNode: TreeNode, currentDepth: Int = 0) -> [String] {
        guard currentDepth < index else {
            return [treeNode.hash]
        }
        var leaftArray = [String]()
        if let left = treeNode.left {
            leaftArray = leaftArray + getHashAt(index, treeNode: left, currentDepth: currentDepth + 1)
        }
        if let right = treeNode.right {
            leaftArray = leaftArray + getHashAt(index, treeNode: right, currentDepth: currentDepth + 1)
        }
        return leaftArray
    }
}
