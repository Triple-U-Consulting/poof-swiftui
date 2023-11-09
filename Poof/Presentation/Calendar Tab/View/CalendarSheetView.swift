//
//  CalendarSheetView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/11/23.
//

import SwiftUI

struct CalendarSheetView: View {
    @EnvironmentObject private var vm: CalendarViewModel
    
    @Binding private(set) var index: Int
    @Binding private(set) var showSheet: Bool
    @Binding private(set) var showEditSheet: Bool

    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, spacing:0){
                Component.DefaultText(text: "Tracked on \(DateFormatUtil.shared.dateToString(date: vm.currentDateSelected, to: "d MMMM yyyy"))")
                    .padding(.bottom, 24)
                if vm.processedKambuhData[vm.currentDateSelected] != nil {
                    ForEach(vm.processedKambuhData[vm.currentDateSelected]!.indices, id:\.self) { idx in
                        CalendarSheetDetailView(index: idx, bindingIndex: $index, showSheet: $showSheet, showEditSheet: $showEditSheet)
                            .environmentObject(vm)
                    }
                } else {
                    Component.DefaultText(text: "No inhaler usage tracked")
                        .font(.systemButtonText)
                }
            }
        }
        .frame(width: .infinity)
        .padding(26)
        .ignoresSafeArea()
        .presentationDetents([.height(500), .large])
        .presentationDragIndicator(.visible)
    }
}

struct CalendarSheetDetailView: View {
    @EnvironmentObject private var vm: CalendarViewModel
    
    let index: Int
    
    @Binding private(set) var bindingIndex: Int
    @Binding private(set) var showSheet: Bool
    @Binding private(set) var showEditSheet: Bool
    
    var body: some View {
        VStack (spacing:0) {
            HStack (spacing:0) {
                Text(Image(systemName: "clock"))
                    .font(.systemHeadline)
                    .foregroundColor(.primary1)
                Component.DefaultText(text: " \(vm.getCurrentKambuhTime(idx: index))")
                    .font(.systemHeadline)
                    .foregroundColor(.black)
                Spacer()
                Component.DefaultText(text: "Edit")
                    .font(.systemHeadline)
                    .foregroundColor(.primary1)
                    .onTapGesture {
                        withAnimation {
                            self.bindingIndex = index
                            self.showSheet.toggle()
                            self.showEditSheet.toggle()
                        }
                    }
            }
            
            HStack (alignment: .top, spacing:0) {
                VStack (alignment: .leading, spacing:0) {
                    Component.DefaultText(text: "Inhaler Usage")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "\(vm.getCurrentKambuhTotalPuff(idx: index)) Inhaler Puff")
                        .padding(.top, 8)
                    
                    Component.DefaultText(text: "Breathing Difficulty Scale")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "\(vm.getCurrentKambuhScale(idx: index))")
                        .padding(.top, 8)
                    
                    Component.DefaultText(text: "Triggered By")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "XXX")
                        .padding(.top, 8)
                        .padding(.bottom, 12)
                }.padding(.leading, 12)
                
                Spacer()
            }
            .frame(width: 338)
            .background(.gray6)
            .cornerRadius(10)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
    }
}
