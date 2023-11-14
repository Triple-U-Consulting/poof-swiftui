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
    @State private var currProgressDate = Date()
    @State private var showSheet = false
    @State private var recentMonth = 2 //means show 3 months
    @State var selectedDate: Date?
    @State var pickerMonth: Int = Calendar.current.component(.month, from: Date.now)
    @State var pickerYear: Int = Calendar.current.component(.year, from: Date.now)
    private let weekDaysData: [String] = ["S", "S", "R", "K", "J", "S", "M"]
    private let vm = CalendarViewModel()
    
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
                        let month = vm.plusMonth(date: currProgressDate, value: index)
                        CalendarMonthView(currProgressDate: month, selectedDate: $selectedDate)
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
            CalendarDatePickerView(pickerMonth: $pickerMonth, pickerYear: $pickerYear, currProgressDate: $currProgressDate, showSheet: $showSheet)
                .environmentObject(vm)
        }

    }
}

#Preview {
    CalendarTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}


struct CalendarDatePickerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: CalendarViewModel
    @Binding var pickerMonth: Int
    @Binding var pickerYear: Int
    @Binding var currProgressDate: Date
    @Binding var showSheet: Bool
    
    let years = Array(1900...Calendar.current.component(.year, from: Date.now))
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        NavigationView {
            HStack {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Picker("", selection: $pickerMonth) {
                        ForEach(1...months.count, id: \.self) {
                            Text(months[$0 - 1])
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                LazyVStack(alignment: .leading, spacing: 0) {
                    Picker("", selection: $pickerYear) {
                        ForEach(years, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .padding(.horizontal, 26)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: NSLocalizedString("Selesai", comment: ""), action: {
                        currProgressDate = vm.getDateFromMonthYear(month: pickerMonth ?? Calendar.current.component(.month, from: Date.now), year: pickerYear ?? Calendar.current.component(.year, from: Date.now))
                        showSheet.toggle()
                    })
                }
            }
        }
        .frame(width: .infinity)
        .ignoresSafeArea()
        .presentationDetents([.height(200), .large])
        .presentationDragIndicator(.hidden)
    }
}
