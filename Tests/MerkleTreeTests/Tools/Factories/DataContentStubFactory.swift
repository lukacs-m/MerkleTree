//
//  DataContentStubFactory.swift
//  
//
//  Created by Martin Lukacs on 05/02/2022.
//

import Foundation

enum DataContentStubFactory {
    static func createStringData(with numberOfGenericString: Int = 5) -> [String] {
        var stringData: [String] = []
        for i in 0 ..< numberOfGenericString {
            let newGeneric = "test\(i)"
            stringData.append(newGeneric)
        }
        
        return stringData
    }
}
