# MerkleTree

[![Language: Swift 5](https://img.shields.io/badge/language-swift5-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 13+](https://img.shields.io/badge/platform-iOS%2013%2B-blue.svg?style=flat)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/freshOS/ws/blob/master/LICENSE)

MerkleTree is a little package to help generate and test merkle trees in swift. 

## What
- [x] Tree factory
- [x] Use of generic protocols 
- [x] Tested
- [x] Pure Swift, simple, lightweight

## Getting Started

* [Install it](#install-it)
* [Create a Merkle tree](#create-a-merkle-tree)
* [Get some tree informations](#get-some-tree-information)


### Install it

You'll need `Xcode` to run this package.

`MerkleTree` is installed via the official [Swift Package Manager](https://swift.org/package-manager/).  

Select `Xcode`>`File`> `Swift Packages`>`Add Package Dependency...`  
and add `https://github.com/lukacs-m/MerkleTree`.

Then just `import MerkleTree` in your files. 

### Create a Merkle tree

The first step you need to take is to instanciate a **TreeFactory**.
After that you only need to call the `createMerkeTree` function passing it a array of string as data.
Note that it will throw an error if the array is empty

```swift
// Default
let treeFactory = TreeFactory()
let fakeData = ["data1", "data2"]

let merkleTreeV1 = treeFactory.createMerkleTree(with: fakeData)
let merkleTreeV2 = treeFactory.createRealMerkleTree(with: fakeData)
```

### Get some tree information

Once the tree is created you can a few different information like the root node, the height or an array of node hashes from a specific level of the tree.

```swift
// Get root node
let rootNode = merkleTree.root

//Get tree height
let height = merkleTree.height

//Get node hashes from a specific level
let hashArray = merkleTree.level(at: 1)
```

The factory can create two types of Merkle tree that don't process the odd nodes the same way.
The `createMerkleTree` function returns a merkle tree taht when containing odd numbers of node will pump the hash of the child node to the parent.
The `createRealMerkleTree` function treas the odd node in a different way. It will duplicate the child node hash et create a hash from the addition of the childs duplicated hash value. This results in a parent having a different hash from it single  child.

## Testing

The package can be tested in two way:

- Executing the tests from the test package. They are regrouped in the **MerkleTreeTests** file.
- Playing with the TestMerkleTreePlayground. This playground imports the `MerkleTree` package and gives you an overview of it.
