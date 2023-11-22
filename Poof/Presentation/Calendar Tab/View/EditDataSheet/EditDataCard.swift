//
//  CalendarEditSheetDetailView.swift
//  Poof
//
//  Created by Angela Christabel on 09/11/23.
//

import SwiftUI

struct EditDataCard: View {
    @EnvironmentObject private var vm: CalendarViewModel
    
    let index: Int
    
    @Binding private(set) var showSheet: Bool
    
    @State private var selectedIrritant: String = "Choose"
    @State private var skalaSesak: Double = 0
    @State private var showSkalaSesak: Bool = false
    @State private var noSkalaSesak: Bool = false
    
    var body: some View {
        List {
            VStack (spacing:0) {
                HStack (spacing:0) {
                    Text(Image(systemName: "clock"))
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                    Component.DefaultText(text: " \(vm.getCurrentKambuhTime(idx: index))")
                        .font(.systemHeadline)
                        .foregroundColor(.black)
                    Spacer()
                    Component.DefaultText(text: "\(vm.getCurrentKambuhTotalPuff(idx: index)) Puff Terdeksi")
                        .font(.systemHeadline)
                        .foregroundColor(.black)
                }
                .padding(.all, 12)
            }
            .frame(width: .infinity)
            .background(.primary3)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 10
                )
            )
            .ignoresSafeArea()
            .listRowInsets(EdgeInsets())
            
            HStack {
                Component.DefaultText(text: "Skala Sesak")
                
                Spacer()
                Component.TextWithBorder(text: "\(vm.getCurrentKambuh(index: index).scale ?? 0)")
                    .onTapGesture {
                        showSkalaSesak.toggle()
                    }
            }
            
            if showSkalaSesak {
                Component.FormSlider(
                    value: $skalaSesak,
                    toggle: $noSkalaSesak
                )
            }
            
            HStack {
                Component.DefaultText(text: "Alergen")
                Spacer()
                Component.MenuWithBorder(selection: $selectedIrritant, menuSelection: .constant(["Pollen", "Pet", "Exercise", "Others"]))
            }
        }

    }
}
//
//#Preview {
//    CalendarEditSheetDetailView(index: 0, showSheet: .constant(true))
//        .environmentObject(CalendarViewModel())
//}
