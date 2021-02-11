//
//  measureSystems.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/29/20.
//

import Foundation

struct measureSystems: Identifiable,Codable {
    
    let id = UUID()
    var name:String = ""
    var iconSF:String = ""
    var base:String = ""
    var units: [unitsStruct]
    
}
