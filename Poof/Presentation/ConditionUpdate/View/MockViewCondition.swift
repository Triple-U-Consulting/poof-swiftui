//
//  MockViewCondition.swift
//  Poof
//
//  Created by Geraldy Kumara on 06/11/23.
//

import SwiftUI

struct MockViewCondition: View {
    
    @EnvironmentObject var vm: ConditionViewModel
    @State private var date: Date = Date()
    
    var body: some View {
        VStack{
            
            DatePicker("Choose Date", selection: $date, displayedComponents: [.date])
            
            ForEach(vm.kambuhList.indices, id: \.self) { idx in
                Text("\(vm.kambuhList[idx].id)")
                Text("\(vm.kambuhList[idx].totalPuff)")
                Text("\(vm.kambuhList[idx].scale ?? 0)")
                Text("\(vm.kambuhList[idx].trigger ?? true)" as String)
                
                //                TextField("Input scale", value: $vm.scale[idx], formatter: NumberFormatter())
                
                TextField("Input scale", text: Binding(
                    get: { String(vm.scale[idx]) },
                    set: { vm.scale[idx] = Int($0) ?? 0 }
                )).textInputAutocapitalization(.none)
                
                TextField("Enter a boolean", text: Binding(
                    get: { String(vm.trigger[idx]) },
                    set: { vm.trigger[idx] = $0.lowercased() == "true" }
                )).textInputAutocapitalization(.none)
            }
            
            
            Component.DefaultButton(text: "Fetch") {
                vm.fetchKambuhDataByDate(date: date)
            }
            
            Component.DefaultButton(text: "Update") {
                vm.updateKambuhData(scale: vm.scale, trigger: vm.trigger)
            }
            
        }
    }
}

#Preview {
    MockViewCondition()
        .environmentObject(ConditionViewModel())
}
