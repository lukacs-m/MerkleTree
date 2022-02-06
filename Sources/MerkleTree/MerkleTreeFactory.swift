import Foundation

public struct TreeFactory {
    public init() {}
}

// MARK: - Merkle tree creation
extension TreeFactory: MerkleTreeCreating {
    /// Enable the creation of a merkle tree based on a array of string
    /// - Parameter data: The array of string used as the base of the merkle tree
    /// - Returns: A merkle tree conforming to the `TreeProcessing` protocol. Returns a `MerkleTreeError` in case of empty data.
    public func createMerkleTree(with data: [String]) throws -> TreeProcessing {
        guard !data.isEmpty else {
            throw(MerkleTreeError.empty("You should have at least one set of data to create a merkle tree"))
        }
        let merkleTreeHeight = ceil(log2(Double(data.count)))
        var leafsArray: [TreeNode] = data.map { MerkleTreeNode(stringData: $0) }
        
        while leafsArray.count != 1 {
            var newLeafsArray = [TreeNode]()
            while leafsArray.count > 0 {
                let leftNode  = leafsArray.removeFirst()
                let rightNode = leafsArray.count > 0 ? leafsArray.removeFirst() : leftNode
                newLeafsArray.append(createNextLevelNode(with: leftNode, and: rightNode))
            }
            leafsArray = newLeafsArray
        }
        
        return MerkleTree(treeGraph: leafsArray, height: merkleTreeHeight)
    }
}

// MARK: - Utils
private extension TreeFactory {
    /// Computes the new layer node from 2 children node
    /// - Parameters:
    ///   - leftNodeChild: The left side tree node
    ///   - rightNodeChild: The right side tree node
    /// - Returns: A new node containing the hash value of the combination of the two child node hash value
    func createNextLevelNode(with leftNodeChild: TreeNode, and rightNodeChild: TreeNode) -> TreeNode {
        let newHash = (leftNodeChild.hash + rightNodeChild.hash).sha256
        return MerkleTreeNode(hash: newHash, left: leftNodeChild, right: rightNodeChild)
    }
}
