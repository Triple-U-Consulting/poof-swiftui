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
    @Binding var showSheet: Bool
    
    var body: some View {
        ZStack {
            Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
            NavigationView{
                ZStack {
                    Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
                    VStack(alignment: .leading){
                    
                        Text(("\(NSLocalizedString("Dilacak pada", comment: "")) \(DateFormatUtil.shared.dateToString(date: vm.currentDateSelected, to: "dd MMMM yyyy"))"))
                            .padding(.bottom, 32)
                        
                        CalendarEditSheetDetailView(index: index, showSheet: $showSheet)
                            .environmentObject(vm)
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Component.TextButton(text: NSLocalizedString("Simpan", comment: ""), action: {
                            vm.updateKambuhData()
                            self.showSheet.toggle()
                        })
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }
}
