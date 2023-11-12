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
    @State private var showSheet = false
    @State private var recentMonth = 2 //means show 3 months
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                Component.NextButton(text: "\(vm.getCalendarComponentString(date: currProgressDate, format: "LLLL")) \(vm.getCalendarComponentString(date: currProgressDate, format: "yyyy"))", borderColor: .white.opacity(0)) {
                    showSheet.toggle()
                }
                .padding(.top, 8)
                
                HStack (spacing:0) {
                    ForEach(weekDaysData, id:\.self) {dayName in
                        Component.DefaultText(text: "\(dayName)")
                            .font(.systemFootnote)
                            .frame(width: 53, height: 17)
                    }
                    .frame(width: .infinity, height: 17)
                }
                .padding(.top, 16)
                
                Component.CustomDivider(width: userDevice.usableWidth)
                
                ScrollView {
                    
                    ForEach(0...recentMonth, id:\.self) {index in
                        CalendarMonthView(currProgressDate: vm.plusMonth(date: currProgressDate, value: index))
                    }
                }
                .refreshable {
                    currProgressDate = vm.plusMonth(date: currProgressDate, value: -2)
                    recentMonth += 2
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Calendar", fontSize: .systemTitle1)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.gray7)
        }
        .onAppear {
            currProgressDate = vm.plusMonth(date: currProgressDate, value: -recentMonth)
        }
        .sheet(isPresented: self.$showSheet) {
            CalendarDatePickerView(showSheet: $showSheet, currProgressDate: $currProgressDate)
//                .environmentObject(vm)
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
