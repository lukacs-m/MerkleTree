import MerkleTree

let treeFactory = TreeFactory()
let treeData = ["data1","data2","data3","data4","data5"]

guard let merkleTree = try? treeFactory.createMerkleTree(with: treeData) else {
    fatalError("Should be able to create a tree")
}

// MARK: - The hash of the root node
print("Current root hash is\(merkleTree.root.hash)\n")

// MARK: - Height of tree
//Should contain 3 level
print("The current merkle tree contains \(merkleTree.height) levels")

// MARK: - Level Hashes
print("\n********************\n")

print("The root level has \(merkleTree.level(at: 0).count) hashes. They are: \(merkleTree.level(at: 0)) ")

print("\n********************\n")

print("The level 1 of the merkle tree has \(merkleTree.level(at: 1).count) hashes. They are \(merkleTree.level(at: 1)) ")

print("\n********************\n")

print("The level 2 of the merkle tree has \(merkleTree.level(at: 2).count) hashes. They are \(merkleTree.level(at: 2)) ")

print("\n********************\n")

print("The level 3 of the merkle tree has \(merkleTree.level(at: 3).count) hashes. They are \(merkleTree.level(at: 3)) ")

print("\n********************\n")

print("The level 4 of the merkle tree has \(merkleTree.level(at: 4).count) hashes. They are \(merkleTree.level(at: 4)) ")
