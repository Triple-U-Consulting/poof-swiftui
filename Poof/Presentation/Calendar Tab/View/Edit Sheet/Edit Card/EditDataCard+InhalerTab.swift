//
//  EditDataCard.swift
//  Poof
//
//  Created by Angela Christabel on 23/11/23.
//

import SwiftUI

struct EditDataCardInhaler: View {
    @EnvironmentObject private var vm: ConditionViewModel
    
    let key: Date
    let idx: Int
    
//    @Binding private(set) var showSheet: Bool
    
    @State private var selectedIrritant: String = "Choose"
    @State private var skalaSesak: Double = 0
    @State private var showSkalaSesak: Bool = false
    @State private var noSkalaSesak: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack (spacing:0) {
                Text(Image(systemName: "clock"))
                    .font(.systemHeadline)
                    .foregroundColor(.primary1)
                Component.DefaultText(text: "\(DateFormatUtil.shared.dateToString(date: vm.processedKambuhData[key]![idx].start, to: "HH.mm"))")
                    .font(.systemHeadline)
                    .foregroundColor(.black)
                Spacer()
                Component.DefaultText(text: "\(vm.processedKambuhData[key]![idx].totalPuff) \(NSLocalizedString("puff terdeteksi", comment: ""))")
                    .font(.systemHeadline)
                    .foregroundColor(.black)
            }
            .padding(12)
            .background(.primary3)
            
            VStack(spacing: 12) {
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
                
                Divider()
                
                HStack {
                    Component.DefaultText(text: "Alergen")
                    Spacer()
                    Component.MenuWithBorder(selection: $selectedIrritant, menuSelection: .constant(["Pollen", "Pet", "Exercise", "Others"]))
                }
            }
            .padding(12)
        }
        .frame(width: 338)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
    }
}
