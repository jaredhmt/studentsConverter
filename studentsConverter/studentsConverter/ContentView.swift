//
//  ContentView.swift
//  studentsConverter
//
//  Created by Jared Hale on 12/13/20.
//  Version History tracked with git.
//

import SwiftUI


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
    
    
    @State var selectedMeasure = 0
    var measurements = ["hare","shippingbox","square.and.pencil","scalemass","gauge"]
    var measureLabels = ["Velocity","Volume","Custom","Weight","Pressure"]
    var iconName:String {
        measurements[selectedMeasure]
    }
    var titleLabel:String {
        measureLabels[selectedMeasure]
    }
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                Picker(selection: $selectedMeasure, label: Text("Selected Measure")) {
                    ForEach(0 ..< measurements.count) {
                        Image(systemName: self.measurements[$0])
                        //Text(self.measureLabels[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .font(.system(size:40))
                .scaleEffect(CGSize(width: 1, height: 1))
                .frame(height: 35)
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
                if self.selectedMeasure == 0 {
                    velocityView()
                }
                else if self.selectedMeasure == 1 {
                    volumeView()
                }
                else {
                    Spacer()
                }
            }
            
        }
        
    }
    
    
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
