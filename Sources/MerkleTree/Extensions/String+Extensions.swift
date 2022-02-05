//
//  String+Extensions.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

import CryptoKit
import Foundation

extension String {
    /// Return a sha256 hash representation of the current String
    var sha256: String {
        guard let data = self.data(using: .utf8) else { return "" }
        return hexString(SHA256.hash(data: data).makeIterator())
    }
    
    private func hexString(_ iterator: Array<UInt8>.Iterator) -> String {
        return iterator.map { String(format: "%02x", $0) }.joined()
    }
}
