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
    @State private var menuItem1 = false
    @State private var menuItem2 = false
    @State private var menuItem3 = false
    @State private var menuItem4 = false
    @State private var menuItem5 = false
    
    var inMenuNavigator: Bool {
        menuItem1 || menuItem2 || menuItem3 || menuItem4 || menuItem5
    }
    
    
    
    var body: some View {
        ZStack{
            ZStack{
                
                NavigationView{
                    ZStack{
                        
                        VStack {
                            HStack{
                                VStack (alignment: .leading, spacing: 20){
                                    NavigationLink(destination: customUnitEditorView(), isActive: $menuItem1) {
                                        menuElement(menuTxt: "Manage Custom Units")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: UnitManagerView().navigationBarTitle("Units Manager", displayMode: .inline), isActive: $menuItem2) {
                                        menuElement(menuTxt: "Manage Displayed Units")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: SIPrefixesView().navigationBarTitle("SI Prefixes", displayMode: .inline), isActive: $menuItem3) {
                                        menuElement(menuTxt: "SI Prefixes")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: Text("Some Setting1").navigationBarTitle("Setting1", displayMode: .inline), isActive: $menuItem4) {
                                        menuElement(menuTxt: "Some Setting1")
                                    }
                                    .foregroundColor(.primary)
                                    NavigationLink(destination: VStack{
                                        ColorPicker("ColorPicker", selection: /*@START_MENU_TOKEN@*/.constant(.red)/*@END_MENU_TOKEN@*/)
                                        Text("Choose Color Scheme")
                                        
                                    }.navigationBarTitle("Accent Color Picker", displayMode: .inline), isActive: $menuItem5) {
                                        menuElement(menuTxt: "Accent Color Picker")
                                    }
                                    .foregroundColor(.primary)
                                }.padding(.top, 10)
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding(.leading, 15)
                    }.navigationBarTitle("Menu")
                    .background(Color.clear)
                }
                .ignoresSafeArea(edges: .all)
                .background(Color.clear)
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                self.show.toggle()
                                self.menuItem1 = false
                                self.menuItem2 = false
                                self.menuItem3 = false
                                self.menuItem4 = false
                                self.menuItem5 = false
                            }
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 25, height: 25)
                                //                                .font(.system(size: 25))
                                .padding(.trailing)
                                .padding(.top, 5)
                                .foregroundColor(.primary)
                        }
                        //.opacity((self.show && !self.inMenuNavigator) ? 1 : 0)
                    }
                    Spacer()
                }
                .background(Color.clear)
            }
            .background(Color.clear)
            .opacity(self.show ? 1 : 0)
            
            ZStack {
                ConvertView(show: self.$show)
                
            }
            .cornerRadius(self.show ? 15 : 0)
            .scaleEffect(self.show ? 0.8 : 1)
            .offset(x: self.show ? 175 : 0, y: self.show ? 50 : 0)
            .opacity(withAnimation(.spring()) {self.inMenuNavigator ? 0 : 1})
        }
        
    }
    
    
}

struct menuElement: View {
    
    var menuTxt: String
    
    var body: some View {
        HStack (spacing: 5){
            Capsule()
                .fill(Color.accentColor)
                .frame(width: 8, height: 25)
            Text(menuTxt)
        }
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
