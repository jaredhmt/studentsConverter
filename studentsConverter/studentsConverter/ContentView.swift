//
//  ContentView.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/13/20.
//  Version History tracked with git.
//

import SwiftUI
import Foundation


struct ContentView: View {
    
    @State var show = false
    
    
    var body: some View {
        ZStack{
            ZStack {
                ConvertView(show: self.$show)
                
            }
            .cornerRadius(self.show ? 15 : 0)
            .scaleEffect(self.show ? 0.8 : 1)
            .offset(x: self.show ? 175 : 0, y: self.show ? 50 : 0)
            
            ZStack{
                
                NavigationView{
                    ZStack{
                        
                        VStack {
                            HStack{
                                VStack (alignment: .leading, spacing: 20){
                                    NavigationLink(destination: customUnitEditorView()) {
                                        Text("Manage Custom Units")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: customUnitEditorView()) {
                                        Text("Manage Displayed Units")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: customUnitEditorView()) {
                                        Text("Some Setting0")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: customUnitEditorView()) {
                                        Text("Some Setting1")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: customUnitEditorView()) {
                                        Text("Some Setting2")
                                    }
                                    .foregroundColor(.primary)
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding(.leading, 15)
                    }.navigationBarTitle("Menu")
                }
                .background(Color.clear)
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
                .background(Color.clear)
            }
            .background(Color.clear)
            .opacity(self.show ? 1 : 0)
            
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
