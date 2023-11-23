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
    @Binding private(set) var showAddSheet: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack (alignment: .leading, spacing:0){
                    if vm.processedKambuhData[vm.currentDateSelected] != nil {
                        ForEach(vm.processedKambuhData[vm.currentDateSelected]!.indices, id:\.self) { idx in
                            CalendarSheetDetailView(index: idx, bindingIndex: $index, showSheet: $showSheet, showEditSheet: $showEditSheet)
                                .environmentObject(vm)
                        }
                    } else {
                        Component.DefaultText(text: "Tidak ada data inhaler yang terekam.", textAlignment: .leading)
                            .font(.systemButtonText)
                    }
                }
                .padding(.horizontal, 24)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.TextButton(text: "Hapus", color: .red, action: {
                        //logic
                    })
                }
                ToolbarItem(placement: .principal) {
                    Component.DefaultText(text: " \(DateFormatUtil.shared.dateToString(date: vm.currentDateSelected, to: "d MMMM yyyy"))")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: "Tambah", action: {
                        self.showSheet.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                            self.showAddSheet.toggle()
                        })
                    })
                }
            }
            .background(.gray7)
        }
        .frame(width: .infinity)
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
                            self.bindingIndex = index
                            self.showSheet.toggle()
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                                self.showEditSheet.toggle()
                            })
                        }
                }
                .padding(.all, 12)
            }
            .frame(width: 338)
            .background(.primary3)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 10
                )
            )
            
            HStack (alignment: .top, spacing:0) {
                VStack (alignment: .leading, spacing:0) {
                    Component.DefaultText(text: "Penggunaan Inhaler")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "\(vm.getCurrentKambuhTotalPuff(idx: index)) Semprot")
                        .padding(.top, 8)
                    
                    Component.DefaultText(text: "Skala Sesak")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "\(vm.getCurrentKambuhScale(idx: index))")
                        .padding(.top, 8)
                    
                    Component.DefaultText(text: "Dipicu Oleh")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "Belum ada data")
                        .padding(.top, 8)
                        .padding(.bottom, 12)
                }
                .padding(.leading, 12)
                
                Spacer()
            }
            .frame(width: 338)
            .background(.white)
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 0
                )
            )
            .padding(.bottom, 24)
        }
    }
}
