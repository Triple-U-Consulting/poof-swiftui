//
//  CalendarEditSheetView.swift
//  Poof
//
//  Created by Angela Christabel on 09/11/23.
//

import SwiftUI

struct CalendarEditSheetView: View {
    @EnvironmentObject var vm: CalendarViewModel
    
    let key: Date
    let index: Int
    
    @State var showConfDialog: Bool = false
    @Binding var showSheet: Bool
    @Binding var showEditSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing:0) {
                EditDataCardCalendar(key: key, idx: index)
                    .environmentObject(vm)
                Spacer()
            }
            .padding(.horizontal, 24)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.TextButton(text: "Batal", color: .red, action: {
                        self.showEditSheet.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                            self.showSheet.toggle()
                        })
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Component.DefaultText(text: " \(DateFormatUtil.shared.dateToString(date: vm.currentDateSelected, to: "d MMMM yyyy"))")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: "Simpan", action: {
                        showConfDialog = true
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
            .frame(width: .infinity)
            .background(.gray7)
            .navigationBarTitleDisplayMode(.inline)
        }
        .ignoresSafeArea()
        .presentationDetents([.height(500), .large])
        .presentationDragIndicator(.visible)
    }
}
