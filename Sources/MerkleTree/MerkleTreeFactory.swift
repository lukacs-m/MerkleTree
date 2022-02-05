import Foundation

public struct TreeFactory {
    public init() {}
}

// MARK: - Merkle tree creation
extension TreeFactory: MerkleTreeCreating {
    public func createMerkleTree(with data: [String]) throws -> TreeProcessing {
        guard !data.isEmpty else {
            throw(MerkleTreeError.empty("You should have at least one set of data to create a merkle tree"))
        }
        let merkleTreeHeight = ceil(log2(Double(data.count)))
        var leaftArray: [TreeNode] = data.map { MerkleTreeNode(stringData: $0) }
        
        while leaftArray.count != 1 {
            var tmpArray = [TreeNode]()
            while leaftArray.count > 0 {
                let leftNode  = leaftArray.removeFirst()
                let rightNode = leaftArray.count > 0 ? leaftArray.removeFirst() : leftNode
                tmpArray.append(createNextLevelNode(with: leftNode, and: rightNode))
            }
            leaftArray = tmpArray
        }
        
        return MerkleTree(treeGraph: leaftArray, height: merkleTreeHeight)
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
