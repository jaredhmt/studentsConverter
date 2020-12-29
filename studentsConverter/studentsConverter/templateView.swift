//
//  templateView.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/29/20.
//

import SwiftUI

struct templateView: View {

    let mph2mps = converStruct(5280 * 12 * 2.54 / 3600 / 100)
    let fps2mps = converStruct(12 * 2.54 / 100)
    let mps2mps = converStruct(1)
    let kmph2mps = converStruct(1000 / 3600)
    let knot2mps = converStruct(1852 / 3600)
    
    @State var inputVal:Float = 0.0
    @State var outputVal:Float = 0.0
    @State var userInput:String = "0"
    @State var selectedUnits = [0, 1]
    @State var baseVal:Float = 0.0
    var units = ["miles per hour","feet per second","meters per second", "kilometers per hour","knots"]
    
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
            self.baseVal = mph2mps.convert(Float(userInput)!)
        }
        else if refIn == 1 {
            self.baseVal = fps2mps.convert(Float(userInput)!)
        }
        else if refIn == 2 {
            self.baseVal = mps2mps.convert(Float(userInput)!)
        }
        else if refIn == 3 {
            self.baseVal = kmph2mps.convert(Float(userInput)!)
        }
        else if refIn == 4 {
            self.baseVal = knot2mps.convert(Float(userInput)!)
        }
        
        // convert m/s to output
        let refOut = self.selectedUnits[1]
        if refOut == 0 {
            self.outputVal = mph2mps.convert(self.baseVal,true)
        }
        else if refOut == 1 {
            self.outputVal = fps2mps.convert(self.baseVal,true)
        }
        else if refOut == 2 {
            self.outputVal = mps2mps.convert(self.baseVal,true)
        }
        else if refOut == 3 {
            self.outputVal = kmph2mps.convert(self.baseVal,true)
        }
        else if refOut == 4 {
            self.outputVal = knot2mps.convert(self.baseVal,true)
        }
    }
}

struct templateView_Previews: PreviewProvider {
    static var previews: some View {
        templateView()
    }
}
