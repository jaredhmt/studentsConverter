//
//  volumeView.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/28/20.
//

import Foundation
import SwiftUI

struct volumeView: View {
    
    
    let ml2met3 = converStruct(1 / 1000000)
    let cm32met3 = converStruct(1 / 1000000)
    let met32met3 = converStruct(1)
    let gal2met3 = converStruct(231 * pow(2.54/100,3))
    let ft32met3 = converStruct(pow(12*2.54/100,3))
    
    @State var inputVal:Float = 0.0
    @State var outputVal:Float = 0.0
    @State var userInput:String = "0"
    @State var selectedUnits = [0, 1]
    @State var baseVal:Float = 0.0
    var units = ["milileters","cubic centimeters","cubic meters", "US gallons","cubic feet"]
    
    var body: some View {
        VStack {
            HStack {
                VStack{
                    Text("Input Value:")
                        .padding([.bottom, .trailing], 10)
                    TextField("Input", text: $userInput, onEditingChanged: {_ in
                        //                    performConv()
                    })
                    .frame(width: 120,height: 30+20, alignment: .leading)
                    .font(.system(size: 30))
                    .layoutPriority(0)
                    .background(Color(red: 0.66, green: 0.66, blue: 0.66, opacity: 0.14))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                }//.padding(.trailing,1)
                Picker(selection: $selectedUnits[0], label: Text("Input Units")) {
                    ForEach(0 ..< units.count) {
                        Text(self.units[$0])
                    }
                }
                .frame(width: 220)
                .clipped()
                .onChange(of: selectedUnits[0]) { _ in
                    closeKeyboard()
                    performConv()
                }
            }
            .padding(.bottom, 20.0)
            HStack {
                VStack{
                    Text("Ouput Value:")
                        .padding([.bottom, .trailing], 10)
                    Text("\(self.outputVal, specifier: "%.3f")")
                        .frame(width:120, alignment: .leading)
                        .font(.system(size: 30))
                        .layoutPriority(1)
                        .lineLimit(1)
                }
                Picker(selection: $selectedUnits[1], label: Text("Input Units")) {
                    ForEach(0 ..< units.count) {
                        Text(self.units[$0])
                    }
                }
                .frame(width: 220)
                .clipped()
                .onChange(of: selectedUnits[1]) { _ in
                    closeKeyboard()
                    performConv()
                }
            }
            Spacer()
        }
        //    .onTapGesture {closeKeyboard()}
        //    .padding(.horizontal)
    }
    func performConv() {
        // convert input to m/s
        let refIn = self.selectedUnits[0]
        if refIn == 0 {
            self.baseVal = ml2met3.convert(Float(userInput)!)
        }
        else if refIn == 1 {
            self.baseVal = cm32met3.convert(Float(userInput)!)
        }
        else if refIn == 2 {
            self.baseVal = met32met3.convert(Float(userInput)!)
        }
        else if refIn == 3 {
            self.baseVal = gal2met3.convert(Float(userInput)!)
        }
        else if refIn == 4 {
            self.baseVal = ft32met3.convert(Float(userInput)!)
        }
        
        // convert m/s to output
        let refOut = self.selectedUnits[1]
        if refOut == 0 {
            self.outputVal = ml2met3.convert(self.baseVal,true)
        }
        else if refOut == 1 {
            self.outputVal = cm32met3.convert(self.baseVal,true)
        }
        else if refOut == 2 {
            self.outputVal = met32met3.convert(self.baseVal,true)
        }
        else if refOut == 3 {
            self.outputVal = gal2met3.convert(self.baseVal,true)
        }
        else if refOut == 4 {
            self.outputVal = ft32met3.convert(self.baseVal,true)
        }
    }
}

