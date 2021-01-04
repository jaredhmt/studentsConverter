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

// Conversion Structure Setup
struct converStruct {
    var convFactor:Float = 0.0
    init(_ a:Float) {
        convFactor = a
    }
    func convert (_ inVal:Float, _ out:Bool = false) -> Float {
        var output:Float = 0
        if out {
            output = inVal / convFactor
        }
        else {
            output = inVal * convFactor
        }
        return output
    }
}

// End Conversion Structure Setup

