//
//  ContentView.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/13/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputVal:Float = 0.0
    @State var outputVal:Float = 0.0
    @State var userInput:String = "0"
    @State var selectedUnits:Int = 1
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack{
                    Text("Input Value:")
                        .padding([.bottom, .trailing], 10)
                    TextField("Input", text: $userInput)
                        .frame(width: 90.0)
                        .font(.system(size: 30))
                }
                Picker(selection: .constant(1),
                       label: Text("Input Units")) {
                    Text("miles per hour").tag(1)
                    Text("cubic feet").tag(2)
                    Text("kilograms").tag(3)
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
                        .font(.system(size: 30))
                }
                Picker(selection: .constant(1),
                       label: Text("Output Units")) {
                    Text("meters per second").tag(1)
                    Text("milileters").tag(2)
                    Text("slugs").tag(3)
                }
                .padding(.trailing,10)
                .fixedSize(horizontal: true, vertical: true)
                
            }
            Spacer()
            Button(action: {
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
                    .font(.system(size: 45))
                    .fontWeight(.heavy)
                    
            }
            .padding(.bottom, 80.0)
        }
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
