//
//  ContentView.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/13/20.
//  Version History tracked with git.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputVal:Float = 0.0
    @State var outputVal:Float = 0.0
    @State var userInput:String = "0"
    @State var selectedUnits = [0, 1]
    var units = ["miles per hour","feet per second","meters per second", "kilometers per hour","knots"]
    
    var body: some View {
        VStack {
            Spacer()
            Text("Velocity")
                .font(.system(size: 45))
                .fontWeight(.black)
            HStack {
                VStack{
                    Text("Input Value:")
                        .padding([.bottom, .trailing], 10)
                    TextField("Input", text: $userInput)
                        .frame(width: 60.0)
                        .font(.system(size: 30))
                        .layoutPriority(/*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
                Picker(selection: $selectedUnits[0], label: Text("Input Units")) {
                    ForEach(0 ..< units.count) {
                                   Text(self.units[$0])
                                }
                }
                .padding(.trailing,10)
                .fixedSize(horizontal: true, vertical: true)
            }
            .padding(.bottom, 20.0)
            HStack {
                VStack{
                    Text("Ouput Value:")
                        .padding([.bottom, .trailing], 10)
                    Text(String(self.outputVal))
                        .frame(width:60)
                        .font(.system(size: 30))
                        .layoutPriority(1)
                }
                Picker(selection: $selectedUnits[1], label: Text("Input Units")) {
                    ForEach(0 ..< units.count) {
                                   Text(self.units[$0])
                                }
                }
                .padding(.trailing,10)
                .fixedSize(horizontal: true, vertical: true)
                
            }
            Spacer()
            Button(action: {
                // check if units are converting to self
                if self.selectedUnits[0] == self.selectedUnits[1] {
                    if self.selectedUnits[1] == self.units.count {
                        self.selectedUnits[1] = 0
                    }
                    else {
                        self.selectedUnits[1] += 1
                    }
                }
                // convert input to m/s
                
                
                // convert m/s to output
                
                
                // change this to be a function
                inputVal = Float(userInput)!
                let mph:Float = self.inputVal
                let fph:Float = mph * 5280
                let fps:Float = fph / 3600
                let ips:Float = fps * 12
                let cps:Float = ips * 2.54
                let mps:Float = cps / 100
                self.outputVal = mps
            }) {
                Text("Convert")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
            }
            .padding(.bottom, 80.0)
        }
        .padding(.horizontal)
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 8 Plus")
            ContentView()
                .previewDevice("iPad (8th generation)")
        }
    }
}
