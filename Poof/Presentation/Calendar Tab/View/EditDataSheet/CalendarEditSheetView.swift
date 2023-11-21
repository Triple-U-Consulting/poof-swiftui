//
//  CalendarEditSheetView.swift
//  Poof
//
//  Created by Angela Christabel on 09/11/23.
//

import SwiftUI

struct CalendarEditSheetView: View {
    @EnvironmentObject var vm: CalendarViewModel
    
    let index: Int
    @State var showConfDialog: Bool = false
    @Binding var showSheet: Bool
    @Binding var showEditSheet: Bool
    
    var body: some View {
        ZStack {
            Color.gray7.ignoresSafeArea()
            NavigationView{
                ZStack {
                    Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
                    VStack {
                        LazyVStack(alignment: .leading){
                        
                            Text(("\(NSLocalizedString("Dilacak pada", comment: "")) \(DateFormatUtil.shared.dateToString(date: vm.currentDateSelected, to: "dd MMMM yyyy"))"))
                                .padding(.bottom, 32)
                            
                            CalendarEditSheetDetailView(index: index, showSheet: $showSheet)
                                .environmentObject(vm)
                        }
                        
                        Spacer()
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Component.TextButton(text: "Simpan", action: {
                            showConfDialog = true
                        })
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Component.TextButton(text: "Batal", color: .red, action: {
                            self.showEditSheet.toggle()
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                                self.showSheet.toggle()
                            })
                        })
                    }
                }
                .confirmationDialog(NSLocalizedString("Pastikan data yang diisi sudah sesuai", comment: ""), isPresented: $showConfDialog, actions: {
                    Button {
                        vm.updateKambuhData()
                        self.showSheet.toggle()
                    } label: {
                        Text(NSLocalizedString("Ya, simpan perubahan", comment: ""))
                    }
                }, message: {
                    Text(NSLocalizedString("Pastikan data yang diisi sudah sesuai", comment: ""))
                })
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            .presentationDetents([.height(500), .large])
            .presentationDragIndicator(.visible)
        }
    }
}
