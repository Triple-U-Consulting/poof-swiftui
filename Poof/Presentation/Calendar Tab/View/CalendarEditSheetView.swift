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
    
    var body: some View {
        ZStack {
            Color(.gray8).ignoresSafeArea()
            NavigationView{
                ZStack {
                    Color(.gray8).ignoresSafeArea()
                    VStack(spacing:0) {
                        LazyVStack(alignment: .leading){
                            Text(("\(NSLocalizedString("Dilacak pada", comment: "")) \(DateFormatUtil.shared.dateToString(date: vm.currentDateSelected, to: "dd MMMM yyyy"))"))
                                .padding(.bottom)
                            CalendarEditSheetDetailView(index: index, showSheet: $showSheet)
                                .environmentObject(vm)
                        }
                        
                        Spacer()
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Component.TextButton(text: NSLocalizedString("Simpan", comment: ""), action: {
                            showConfDialog = true
                        })
                    }
                    ToolbarItem(placement:.principal) {
                        Text("Perbaharui Kondisi")
                            .font(.headline)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Component.TextButton(text: NSLocalizedString("Hapus", comment: ""), action: {
                            self.showSheet.toggle()
                        })
                        .foregroundStyle(.red)
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
        }
    }
}
