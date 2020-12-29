//
//  convFuncs.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/28/20.
//

import Foundation


// JSON Decoding
extension Bundle{
    func decode(_ file: String) -> [measureSystems] {
        let decoder = JSONDecoder()
        guard let url = self.url(forResource: "unitSetup.json", withExtension: nil) else {
            fatalError("failed to locate file in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("convFuncs.swift no. 15")
        }
        guard let loaded = try? decoder.decode([measureSystems].self, from: data) else {
            fatalError("Failed to decode")
        }
        return loaded
        //    decoder.decode("unitSetup.json")
    }
}
// END JSON Decoding



