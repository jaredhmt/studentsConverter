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
    
    @State var show = false
    
    
    var body: some View {
        ZStack{
//            (self.show ? Color.gray.opacity(0.5) : Color.clear).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            self.show.toggle()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 25))
                            .padding([.top, .trailing])
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
            }
            .opacity(self.show ? 1 : 0)
            
            VStack {
                Text("MENU")
                    .padding(.top, 50)
                    .padding(.bottom, 25)
                    .font(.title)
                HStack{
                    VStack (alignment: .leading, spacing: 20){
                        Text("Manage Custom Units")
                        Text("Manage Displayed Measurement Types")
                        Text("Some Setting0")
                        Text("Some Setting1")
                        Text("Some Setting2")
                    }
                    Spacer()
                }
                Spacer()
            }
            .opacity(self.show ? 1 : 0)
            .padding(.leading, 15)
            
            ZStack {
                ConvertView(show: self.$show)
                
            }
            .cornerRadius(self.show ? 15 : 0)
            .scaleEffect(self.show ? 0.8 : 1)
            .offset(x: self.show ? 175 : 0, y: self.show ? 50 : 0)
        }
        .ignoresSafeArea(edges: .all)
        
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
