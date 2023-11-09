//
//  CalendarView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 07/11/23.
//

import SwiftUI

struct CalendarTabView: View {
    
    private let weekDaysData: [String] = ["S", "S", "R", "K", "J", "S", "M"]
    private let currProgressDate = Date()
    private let vm = CalendarViewModel()
    
    var body: some View {
        ScrollView {
            HStack (spacing:0) {
                ForEach(weekDaysData, id:\.self) {dayName in
                    Component.DefaultText(text: "\(dayName)")
                        .font(.systemFootnote)
                        .frame(width: 53, height: 17)
                }
                .frame(width: .infinity, height: 17)
                .background(.gray3)
                
            }
            
            ForEach(0...5, id:\.self) {index in
                CalendarMonthView(currProgressDate: vm.plusMonth(date: currProgressDate, value: index))
            }
        }
    }
}

#Preview {
    CalendarTabView()
}
