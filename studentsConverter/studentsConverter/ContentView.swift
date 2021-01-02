//
//  ContentView.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/13/20.
//  Version History tracked with git.
//

import SwiftUI
import Foundation


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

struct ContentView: View {
    
    
    
    var body: some View {
        ConvertView()
    }
    
    
}




func stringConv(_ inFactorStr:String, _ outFactorStr:String, _ initVal:Float) -> Float {
    let exp: NSExpression = NSExpression(format: inFactorStr)
    let inConvFactor: Double = exp.expressionValue(with: nil, context: nil) as! Double
    let outexp: NSExpression = NSExpression(format: outFactorStr)
    let outConvFactor: Double = outexp.expressionValue(with: nil, context: nil) as! Double
    return initVal * Float(inConvFactor) / Float(outConvFactor)
}

func closeKeyboard() {
    UIApplication.shared.windows.forEach { $0.endEditing(true)}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 8 Plus")
    }
}
