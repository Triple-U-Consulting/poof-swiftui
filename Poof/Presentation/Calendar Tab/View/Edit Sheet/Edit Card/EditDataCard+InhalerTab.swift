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
    @Binding var showDeleteDataButton: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack (spacing:0) {
                    Text(Image(systemName: "clock"))
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                    Component.DefaultText(text: "\(DateFormatUtil.shared.dateToString(date: vm.processedKambuhData[key]![idx].start, to: "HH.mm"))")
                        .font(.systemHeadline)
                        .foregroundColor(.black)
                    Spacer()
                    ZStack {
                        Component.DefaultText(text: "\(vm.processedKambuhData[key]![idx].totalPuff) \(NSLocalizedString("puff terdeteksi", comment: ""))")
                            .font(.systemHeadline)
                            .foregroundColor(.black)
                    }
                }
                .padding(12)
                .background(.primary3)
                
                VStack(spacing: 12) {
                    SliderView(noSkalaSesak: $noSkalaSesak, key: key, idx: idx)
                        .environmentObject(vm)
                    
                    Divider()
                    
                    HStack {
                        Component.DefaultText(text: "Alergen")
                        Spacer()
                        Component.MenuWithBorder(selection: $selectedIrritant, menuSelection: .constant(["Pollen", "Pet", "Exercise", "Others"]))
                    }
                }
                .padding(12)
            }
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            
            HStack {
                Spacer()
                VStack {
                    if showDeleteDataButton {
                        Component.DeleteButton {
                            //TODO: logic delete button
                        }
                        .offset(x:12,y:-12)
                    }
                    Spacer()
                }
            }
        }
    }
}
