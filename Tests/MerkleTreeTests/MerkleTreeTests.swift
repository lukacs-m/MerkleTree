import XCTest
@testable import MerkleTree

final class MerkleTreeTests: XCTestCase {
    let treeFactory = TreeFactory()
    
    func test_merkleTreeCreation_withEmptyData_shouldThrowError() throws {
        XCTAssertThrowsError(try treeFactory.createMerkleTree(with: [])) { error in
            XCTAssertTrue(error is MerkleTreeError)
        }
    }
    
    func test_merkleTreeCreation_withData_shouldCreateAValidTree() throws {
        XCTAssertNoThrow(try treeFactory.createMerkleTree(with: DataContentStubFactory.createStringData(with: 2)))
    }
    
    func test_merkleTreeHeight_withData_shouldReturnCorrectHeight() throws {
        guard let treeWith2Level = try? treeFactory.createMerkleTree(with: DataContentStubFactory.createStringData(with: 4)),
        let treeWith3LevelwithOddData = try? treeFactory.createMerkleTree(with: DataContentStubFactory.createStringData(with: 5)),
        let treeWith3LevelwithEvenData = try? treeFactory.createMerkleTree(with: DataContentStubFactory.createStringData(with: 6)) else {
            XCTFail("Should be able to crete a merkle tree")
            return
        }
        XCTAssertEqual(treeWith2Level.height, 2)
        XCTAssertEqual(treeWith3LevelwithOddData.height, 3)
        XCTAssertEqual(treeWith3LevelwithEvenData.height, 3)
    }
    
    func test_merkleTreeRootNode_withData_shouldHaveTheCorrectHash() throws {
        let data = DataContentStubFactory.createStringData(with: 2)
        guard let tree = try? treeFactory.createMerkleTree(with: data) else {
           return XCTFail("Should be able to crete a merkle tree")
        }
        let hash = (data[0].sha256 + data[1].sha256).sha256
        XCTAssertEqual(tree.root.hash, hash)
    }
    
    func test_merkleTreeLevelContent_withData_shouldHaveTheCorrectArrayOfHash() throws {
        let data = DataContentStubFactory.createStringData(with: 4)
        guard let tree = try? treeFactory.createMerkleTree(with: data) else {
           return XCTFail("Should be able to crete a merkle tree")
        }
        let level2Hashs = [data[0].sha256, data[1].sha256, data[2].sha256, data[3].sha256]
        let level1Hashs = [(level2Hashs[0] + level2Hashs[1]).sha256, (level2Hashs[2] + level2Hashs[3]).sha256]
        let level0Hashs = [(level1Hashs[0] + level1Hashs[1]).sha256]

        XCTAssertEqual(tree.level(at: 0).count, 1)
        XCTAssertEqual(tree.level(at: 0), level0Hashs)
        XCTAssertEqual(tree.level(at: 1).count, 2)
        XCTAssertEqual(tree.level(at: 1), level1Hashs)
        XCTAssertEqual(tree.level(at: 2).count, 4)
        XCTAssertEqual(tree.level(at: 2), level2Hashs)
        XCTAssertEqual(tree.level(at: 3).count, 0, "Should be 0 because the level ask is out of bound compare to the tree")
    }
}
