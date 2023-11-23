//
//  SliderView.swift
//  Poof
//
//  Created by Angela Christabel on 23/11/23.
//

import SwiftUI

struct SliderView: View {
    @EnvironmentObject private var vm: ConditionViewModel
    
    @State private var showSkalaSesak: Bool = false
    @Binding var noSkalaSesak: Bool
    
    var key: Date
    var idx: Int
    
//    let labelSkalaSesak = [
//        -2 : "Not Sure",
//        -1 : "Pilih",
//        0 : "Fine",
//        1 : "Mild",
//        2 : "Moderate",
//        3 : "Severe",
//        4 : "Profound"
//    ]
    
    var body: some View {
        HStack {
            Component.DefaultText(text: "Skala Sesak")
            
            Spacer()
//            Component.TextWithBorder(text: "\(labelSkalaSesak[vm.processedKambuhData[key]![idx].scale ?? -1]!)")
            Component.TextWithBorder(text: "\(vm.processedKambuhData[key]![idx].scale ?? 0)")
                .onTapGesture {
                    withAnimation {
                        showSkalaSesak.toggle()
//                        if vm.processedKambuhData[key]![idx].scale == -1 {
//                            vm.processedKambuhData[key]![idx].scale = Int(0)
//                        }
                    }
                }
        }
        
        if showSkalaSesak {
            Component.FormSlider(
                value: Binding(
                    get: { Double(vm.processedKambuhData[key]![idx].scale ?? 0) },
                    set: { vm.processedKambuhData[key]![idx].scale = Int($0) }
                ),
                toggle: $noSkalaSesak
            )
//            .onChange(of: vm.processedKambuhData[key]![idx].scale) { oldValue, newValue in
//                if (newValue != nil) == true { //if true
//                    vm.processedKambuhData[key]![idx].scale = Int(-2)
//                } else {
//                    vm.processedKambuhData[key]![idx].scale = Int(0)
//                }
//            }
        }
    }
}
