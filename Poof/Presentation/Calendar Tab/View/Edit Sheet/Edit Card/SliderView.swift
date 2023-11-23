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
    
    var body: some View {
        HStack {
            Component.DefaultText(text: "Skala Sesak")
            
            Spacer()
            Component.TextWithBorder(text: "\(vm.processedKambuhData[key]![idx].scale ?? 0)")
                .onTapGesture {
                    withAnimation {
                        showSkalaSesak.toggle()
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
        }
    }
}
