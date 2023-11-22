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
        VStack(spacing:0) {
            HStack (alignment:.center) {
                HStack{
                    Image(systemName: "clock").foregroundColor(Color.Main.blueTextSecondary)

                    Text("\(vm.getCurrentKambuhTime(idx: index))")

                }

                Spacer()

                Text("\(vm.getCurrentKambuhTotalPuff(idx: index)) \(NSLocalizedString("puff terdeteksi", comment: ""))")
                    .bold()
            }
            .padding()
            .frame(height: 50)
            .background(.primary5)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 10
                )
            )

            UpdateConditionFromCalendarView(index: index)
                .environmentObject(vm)
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 0
                    )
                )

        }

    }
}

