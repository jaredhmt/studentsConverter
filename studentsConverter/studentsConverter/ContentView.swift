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
    
    @State var selectedMeasure = 0
    
    var iconName:String {
        configData[selectedMeasure].iconSF
    }
    var titleLabel:String {
        configData[selectedMeasure].name
    }
    var unitCounts:Int {
        configData[self.selectedMeasure].units.count
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
                    reSelect(selectedUnits[0],selectedUnits[1],unitCounts)
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
                            .background(Color(red: 0.66, green: 0.66, blue: 0.66, opacity: 0.12))
                            .cornerRadius(10)
                            .keyboardType(.decimalPad)
                        }//.padding(.trailing,1)
                        Picker(selection: $selectedUnits[0], label: Text("Input Units")) {
                            ForEach(0 ..< unitCounts, id: \.self) {
                                Text(configData[self.selectedMeasure].units[$0].unit)
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
                            ForEach(0 ..< unitCounts, id: \.self) {
                                Text(configData[self.selectedMeasure].units[$0].unit)
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
                .onTapGesture {
                    closeKeyboard()
                    self.outputVal = stringConv(
                        self.configData[selectedMeasure].units[selectedUnits[0]].convFactorStr, self.configData[self.selectedMeasure].units[self.selectedUnits[1]].convFactorStr, inputVal)
                    
                }
            }
            
        }
        
    }
    
    func reSelect(_ oldSelection0:Int, _ oldSelection1:Int, _ newLength:Int) {
        if oldSelection0 > newLength - 1 {
            self.selectedUnits[0] = newLength - 1
        }
        if oldSelection1 > newLength - 1 {
            self.selectedUnits[1] = newLength - 1
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
