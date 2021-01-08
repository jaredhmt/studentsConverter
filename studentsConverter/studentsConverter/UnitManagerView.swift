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
                        selectedRow(listUnit: self.configData[i].units[j])
                    }
                }
            }
        }
    }
}

struct selectedRow: View {
    
    var listUnit: unitsStruct
//    @Binding var selectedItems: Set<UUID>
    
    var isSelected: Bool {
        listUnit.enabled
    }
    
    var body: some View {
        HStack {
            Text(self.listUnit.unit)
            Spacer()
            if self.isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.accentColor)
            }
        }
    }
}

struct UnitManagerView_Previews: PreviewProvider {
    static var previews: some View {
        UnitManagerView()
    }
}
