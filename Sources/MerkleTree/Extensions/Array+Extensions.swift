//
//  File.swift
//  
//
//  Created by Martin Lukacs on 07/02/2022.
//

import Foundation

extension Array {
    var merkleTreeHeight: Int {
        Int(ceil(log2(Double(self.count))))
    }
}
