//
//  customUnitEditorView.swift
//  studentsConverter
//
//  Created by Jared Hale on 1/2/21.
//

import SwiftUI

struct customUnitEditorView: View {
    @State var simpleText:String = ""
    
    var body: some View {
        VStack {
            Text("Custom Unit Editor")
                .font(.system(size: 30))
                .bold()
                .padding(.vertical,50)
            
            HStack{
                VStack(alignment: .trailing, spacing: 10) {
                    Text("ID:")
                    Text("Endabled:")
                    Text("Unit:")
                    Text("Conversion Factor:")
                }
                VStack(alignment: .leading, spacing: 10) {
                    TextField("Identification", text: $simpleText)
                    .frame(width: 120,height: 20, alignment: .leading)
                    .background(Color(red: 0.66, green: 0.66, blue: 0.66, opacity: 0.12))
                    .cornerRadius(4)
                    TextField("Enabled", text: $simpleText)
                    .frame(width: 120,height: 20, alignment: .leading)
                    .background(Color(red: 0.66, green: 0.66, blue: 0.66, opacity: 0.12))
                    .cornerRadius(4)
                    TextField("Unit", text: $simpleText)
                    .frame(width: 120,height: 20, alignment: .leading)
                    .background(Color(red: 0.66, green: 0.66, blue: 0.66, opacity: 0.12))
                    .cornerRadius(4)
                    TextField("Factor", text: $simpleText)
                    .frame(width: 120,height: 20, alignment: .leading)
                    .background(Color(red: 0.66, green: 0.66, blue: 0.66, opacity: 0.12))
                    .cornerRadius(4)
                    
                }
            }
            Spacer()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        customUnitEditorView()
    }
}
