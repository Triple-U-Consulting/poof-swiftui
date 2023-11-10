//
//  CalendarView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 07/11/23.
//

import SwiftUI

struct CalendarTabView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    private let weekDaysData: [String] = ["S", "S", "R", "K", "J", "S", "M"]
    @State private var currProgressDate = Date()
    private let vm = CalendarViewModel()
//    @State private var dayDates: [Int] = []
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Component.DefaultText(text: "Calendar")
                Component.NextButton(text: "\(currProgressDate.get(.month)) \(currProgressDate.get(.year))", borderColor: .black) {
                    showSheet.toggle()
                }
                HStack (spacing:0) {
                    ForEach(weekDaysData, id:\.self) {dayName in
                        Component.DefaultText(text: "\(dayName)")
                            .font(.systemFootnote)
                            .frame(width: 53, height: 17)
                    }
                    .frame(width: .infinity, height: 17)
                    .background(.gray3)
                    
                }
                ScrollView {
                    
                    ForEach(0...5, id:\.self) {index in
                        CalendarMonthView(currProgressDate: vm.plusMonth(date: currProgressDate, value: index))
                        //                    CalendarMonthView(currProgressDate: $currProgressDate)
                    }
                }
                .refreshable {
                    currProgressDate = vm.minusMonth(date: currProgressDate, value: -3)
                }
            }
        }
        .sheet(isPresented: self.$showSheet) {
            CalendarDatePickerView(showSheet: $showSheet, currProgressDate: $currProgressDate)
//                .environmentObject(vm)
        }
        .toolbar {
            Component.DefaultText(text: "haha")
        }

    }
}

#Preview {
    CalendarTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}


struct CalendarDatePickerView: View {
    
    @Binding var showSheet: Bool
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: CalendarViewModel
    @Binding var currProgressDate: Date
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, spacing:0){
                HStack {
                    Spacer()
                    Component.DefaultText(text: "Done")
                        .foregroundStyle(.primary1)
                        .onTapGesture {
                            showSheet.toggle()
                        }
                }
//                Text("picker disini")
                DatePicker("", selection: $currProgressDate, displayedComponents: DatePickerComponents.date)
                    .datePickerStyle(WheelDatePickerStyle())
            }
        }
        .frame(width: .infinity)
        .padding(26)
        .ignoresSafeArea()
        .presentationDetents([.height(200), .large])
        .presentationDragIndicator(.hidden)
    }
}
