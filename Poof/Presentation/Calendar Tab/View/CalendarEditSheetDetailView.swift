//
//  CalendarEditSheetDetailView.swift
//  Poof
//
//  Created by Angela Christabel on 09/11/23.
//

import SwiftUI

struct CalendarEditSheetDetailView: View {
    @EnvironmentObject private var vm: CalendarViewModel
    
    let index: Int
    
    @Binding private(set) var showSheet: Bool
    
    var body: some View {
        HStack {
            HStack{
                Image(systemName: "clock").foregroundColor(Color.Main.blueTextSecondary)

                Text("\(vm.getCurrentKambuhTime(idx: index))")
                    .padding(.leading, -3)

            }

            Spacer()

            Text("\(vm.getCurrentKambuhTotalPuff(idx: index)) \(NSLocalizedString("puff terdeteksi", comment: ""))")
        }
        .padding()
        .frame(height: 45)
        .background(Color.Main.backgroundTitleCard)
        .cornerRadius(10)

        UpdateConditionFromCalendarView(index: index)
            .environmentObject(vm)
            .padding(.bottom, 24)
            .padding(.top, -14)
    }
}

