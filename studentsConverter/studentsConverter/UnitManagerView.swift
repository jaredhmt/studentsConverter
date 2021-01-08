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
                        selectedRow(listUnit: self.configData[i].units[j], selectedItems: self.$selectedRows)
                    }
                }
            }
        }
    }
}

struct selectedRow: View {
    
    var listUnit: unitsStruct
    @Binding var selectedItems: Set<UUID>
    
//    init(listUnit: unitsStruct, selectedItems: Binding<Set<UUID>>) {
//        self.listUnit = listUnit
//        self._selectedItems = selectedItems
//        if self.listUnit.enabled {
//            self.selectedItems.insert(self.listUnit.refID)
//        }
//    }
    
    var isSelected: Bool {
        selectedItems.contains(listUnit.refID)
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
        .onTapGesture {
            if self.isSelected {
                self.selectedItems.remove(self.listUnit.refID)
            }
            else {
                self.selectedItems.insert(self.listUnit.refID)
            }
        }
    }
    
}

struct UnitManagerView_Previews: PreviewProvider {
    static var previews: some View {
        UnitManagerView()
    }
}
