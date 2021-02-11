//
//  SIPrefixesView.swift
//  studentsConverter
//
//  Created by Jared Hale on 1/8/21.
//

import SwiftUI

struct SIPrefixesView: View {
    
    let prefixes = ["yota","zeta","exa","peta","tera","giga","mega","kilo","hecto","deka"," ","deci","centi","milli","micro","nano","pico","femto","atto","zepto","yocto"]
    let symbols = ["Y","Z","E","P","T","G","M","k","h","da"," ","d","c","m","μ","n","p","f","a","z","y"]
    let tensPower = ["\u{00B2}\u{2074}","\u{00B2}\u{00B9}","\u{00B9}\u{2078}","\u{00B9}\u{2075}","\u{00B9}\u{00B2}","\u{2079}","\u{2076}","\u{00B3}","\u{00B2}","\u{00B9}","\u{2070}","\u{207B}\u{00B9}","\u{207B}\u{00B2}","\u{207B}\u{00B3}","\u{207B}\u{2076}","\u{207B}\u{2079}","\u{207B}\u{00B9}\u{00B2}","\u{207B}\u{00B9}\u{2075}","\u{207B}\u{00B9}\u{2078}","\u{207B}\u{00B2}\u{00B9}","\u{207B}\u{00B2}\u{2074}"]
    let printOuts = ["1,000,000,000,000,000,000,000,000","1,000,000,000,000,000,000,000","1,000,000,000,000,000,000","1,000,000,000,000,000","1,000,000,000,000","1,000,000,000","1,000,000","1,000","100","10","1","0.1","0.01","0.001","0.000001","0.000000001","0.000000000001","0.000000000000001","0.000000000000000001","0.000000000000000000001","0.000000000000000000000001"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                VStack(alignment: .trailing, spacing: 8){
                    ForEach(self.prefixes, id: \.self){ name in
                        Text(name)
                    }
                }
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: 3, height: 610)
                VStack(alignment: .center, spacing:8){
                    ForEach(self.symbols, id: \.self){ symbol in
                        Text(symbol)
                    }
                }
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: 3, height: 610)
                VStack(alignment: .center, spacing: 8){
                    ForEach(self.tensPower, id: \.self){ power in
                        Text("10\(power)")
                    }
                }
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: 3, height: 610)
                VStack(alignment: .leading, spacing: 8){
                    ForEach(self.printOuts, id: \.self){ number in
                        Text(number)
                    }
                }
            }
            .padding(.horizontal)
            //        .font(.system(size: 15))
        }
    }
}

struct SIPrefixesView_Previews: PreviewProvider {
    static var previews: some View {
        SIPrefixesView()
            .previewDevice("iPhone 8")
    }
}
