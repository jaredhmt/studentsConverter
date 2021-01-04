//
//  UnitManagerView.swift
//  studentsConverter
//
//  Created by Jared Hale on 1/4/21.
//

import SwiftUI

struct UnitManagerView: View {
    
    @State var selectedRows = Set<UUID>()
    let configData: [measureSystems] = Bundle.main.decode("unitSetup.json")
    
    
    var body: some View {
        //        EmptyView()
        let measureCount: Int = self.configData.count
        //        var unitCount:Int = 0
        List (selection: $selectedRows){
            ForEach(0 ..< measureCount) { i in
                Section(header: Text(self.configData[i].name)) {
                    ForEach(0 ..< self.configData[i].units.count){j in
                        Text(self.configData[i].units[j].unit)
                    }
                }
            }
        }
    }
}

struct UnitManagerView_Previews: PreviewProvider {
    static var previews: some View {
        UnitManagerView()
    }
}
