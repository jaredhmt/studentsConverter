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
    
    
    let configData: [measureSystems] = Bundle.main.decode("unitSetup.json")
    
    @State var outputVal:Float = 0.0
    @State var userInput:String = "0"
    var inputVal: Float {
        Float(userInput)!
    }
    @State var selectedUnits = [0, 1]
//    var units = ["miles per hour","feet per second","meters per second", "kilometers per hour","knots"]
    
    @State var selectedMeasure = 0
    
//    var measurements = ["hare","shippingbox","square.and.pencil","scalemass","gauge"]
//    var measureLabels = ["Velocity","Volume","Custom","Weight","Pressure"]
    var iconName:String {
        configData[selectedMeasure].iconSF
    }
    var titleLabel:String {
        configData[selectedMeasure].name
    }
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                Picker(selection: $selectedMeasure, label: Text("Selected Measure")) {
                    ForEach(0 ..< configData.count) {
                        Image(systemName: self.configData[$0].iconSF)
                        //Text(self.measureLabels[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .font(.system(size:40))
                .scaleEffect(CGSize(width: 1, height: 1))
                .frame(height: 35)
                .onChange(of: selectedMeasure) { _ in
                    closeKeyboard()
                    self.outputVal = stringConv(
                        self.configData[selectedMeasure].units[selectedUnits[0]].convFactorStr, self.configData[self.selectedMeasure].units[self.selectedUnits[1]].convFactorStr, inputVal)
                }
            }
            VStack {
                Image(systemName: self.iconName)
                    .font(.system(size: 60, weight: .bold))
                    .padding(.top, 15)
                Text(self.titleLabel)
                    .font(.system(size: 75))
                    .fontWeight(.black)
                    .padding(.bottom, 15)
                    .onTapGesture {
                        closeKeyboard()
                    }
                if self.selectedMeasure == 10 { // changed to 10 from 0
                    velocityView()
                }
                else if self.selectedMeasure == 11 { // changed to 11 from 1
                    volumeView()
                }
                else {
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
                                ForEach(0 ..< configData[self.selectedMeasure].units.count) {
                                    Text(configData[self.selectedMeasure].units[$0].unit)  // Get an error here if the count changes between view items. Unclear why this is...
                                }
                            }
                            .frame(width: 220)
                            .clipped()
                            .onChange(of: selectedUnits[0]) { _ in
                                closeKeyboard()
                                self.outputVal = stringConv(
                                    self.configData[selectedMeasure].units[selectedUnits[0]].convFactorStr, self.configData[self.selectedMeasure].units[self.selectedUnits[1]].convFactorStr, inputVal)
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
                                ForEach(0 ..< configData[self.selectedMeasure].units.count) {
                                    Text(configData[self.selectedMeasure].units[$0].unit) // Error if Count is different between view items. As of now, each will have 5.
                                }
                            }
                            .frame(width: 220)
                            .clipped()
                            .onChange(of: selectedUnits[1]) { _ in
                                closeKeyboard()
                                self.outputVal = stringConv(
                                    self.configData[selectedMeasure].units[selectedUnits[0]].convFactorStr, self.configData[self.selectedMeasure].units[self.selectedUnits[1]].convFactorStr, inputVal)
                            }
                        }
                        Spacer()
                    }
                    //    .onTapGesture {closeKeyboard()}
                    //    .padding(.horizontal)
                }
            }
            
        }
        
    }
    
    let mph2mps = converStruct(5280 * 12 * 2.54 / 3600 / 100)
    let fps2mps = converStruct(12 * 2.54 / 100)
    let mps2mps = converStruct(1)
    let kmph2mps = converStruct(1000 / 3600)
    let knot2mps = converStruct(1852 / 3600)
    
    @State var baseVal:Float = 0.0
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
