import Foundation

public struct TreeFactory {
    public init() {}
}

// MARK: - Merkle tree creation
extension TreeFactory: MerkleTreeCreating {
    /// Enable the creation of a merkle tree based on a array of string.
    /// In this merkle tree the node with only one child have the same hash as their child.
    /// - Parameter data: The array of string used as the base of the merkle tree
    /// - Returns: A merkle tree conforming to the `TreeProcessing` protocol. Returns a `MerkleTreeError` in case of empty data.
    public func createMerkleTree(with data: [String]) throws -> TreeProcessing {
        guard !data.isEmpty else {
            throw(MerkleTreeError.empty("You should have at least one set of data to create a merkle tree"))
        }
        return createTree(with: data)
    }
    
    /// Enable the creation of a merkle tree based on a array of string
    /// In this merkle tree the node with only one child have a hash equal to `(child.hash + child.hash).sha256`
    /// - Parameter data: The array of string used as the base of the merkle tree
    /// - Returns: A merkle tree conforming to the `TreeProcessing` protocol. Returns a `MerkleTreeError` in case of empty data.
    public func createRealMerkleTree(with data: [String]) throws -> TreeProcessing {
        guard !data.isEmpty else {
            throw(MerkleTreeError.empty("You should have at least one set of data to create a merkle tree"))
        }
        return createTree(with: data, and: false)
    }
}

// MARK: - Utils
private extension TreeFactory {
    func createTree(with data: [String], and oddNodeSimplification: Bool = true) -> TreeProcessing {
        var treeNodes: [TreeNode] = data.map { MerkleTreeNode(stringData: $0) }
        
        while treeNodes.count != 1 {
            treeNodes = stride(from: 0, to: treeNodes.endIndex, by: 2).map {
                let leftNode  = treeNodes[$0]
                let rightNode = $0 < treeNodes.index(before: treeNodes.endIndex) ? treeNodes[$0.advanced(by: 1)] : nil
                return createNextLevelNode(with: leftNode, and: rightNode, oddNodeSimplification: oddNodeSimplification)
            }
        }
        
        return MerkleTree(treeGraph: treeNodes, height: data.merkleTreeHeight)
    }

    /// Computes the new layer node from children nodes
    /// - Parameters:
    ///   - leftNodeChild: The left side tree node
    ///   - rightNodeChild: An optional right side node. This can be nill in case of odd child node number
    ///   - oddNodeSimplification: A boolean indicating the underlying hasing process for the new node.
    ///                            If it is true and the right node is nil the parent node will have the same hash as the left child node.
    ///                            Otherwise the hash is a combination of either left and right hash hashed together or an addition of two left hashes hashed together
    /// - Returns: A new node containing the new hash value of the above possible combination
    func createNextLevelNode(with leftNodeChild: TreeNode, and rightNodeChild: TreeNode?, oddNodeSimplification: Bool) -> TreeNode {
        var newHash = leftNodeChild.hash
        
        if !oddNodeSimplification || rightNodeChild != nil {
            let rightHash = rightNodeChild?.hash ?? leftNodeChild.hash
            newHash = (leftNodeChild.hash + rightHash).sha256
        }
        
        return MerkleTreeNode(hash: newHash, left: leftNodeChild, right: rightNodeChild)
    }
}
