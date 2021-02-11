//
//  unitsStruct.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/29/20.
//

import Foundation

struct unitsStruct: Identifiable,Codable {
    
//    var id:Int = 0
    let id = UUID()
    var unit:String = ""
    var enabled:Bool = true
    var convFactorStr = ""
//    let refID = UUID()
}
