//
//  CalendarTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/11/23.
//

import SwiftUI

struct CalendarMonthView: View {
    @ObservedObject private var vm = CalendarViewModel()
    
    let columns = Array(repeating: GridItem(spacing: 0), count:7)
    let currProgressDate: Date
    
//    @Binding var dayDates: [Int]
    @State private var dayDates: [Int] = []
    @State private var showSheet = false
    @State private var showEditSheet = false
    @State private var showAddSheet = false
    
    @State private var indexKambuh = 0
    
    @Binding var selectedDate: Date?
    
    let todayDate = Date()
    
    var body: some View {
        VStack {
            
            //Month
            HStack {
                Text(" ")
                .onAppear {
                    dayDates = vm.showCalendarData(currProgressDate: currProgressDate)
                }
                .onChange(of: currProgressDate) {
                        dayDates = vm.showCalendarData(currProgressDate: currProgressDate)
                }
            }
                        
            //Calendar Data
            LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                
                ForEach(0...6, id:\.self) {index in
                    let temp = vm.firstWeekDayOfMonth(date: currProgressDate)
                    if index == temp {
                        Component.DefaultText(text: "\(vm.getCalendarComponentString(date: vm.plusMonth(date: currProgressDate, value: 0), format: "LLL"))")
                            .font(.systemTitle3)
                            .frame(width: 53, height: 41)
                    } else {
                        Component.DefaultText(text: " ")
                            .frame(width: 53, height: 41)
                    }
                }

                //Day Cell
                ForEach(dayDates.indices, id:\.self) {index in
                    let dayDate = dayDates[index] //["","",1,2,3,4,5,...]
                    
                    //get the current cell date
                    let cellDate = vm.getCellDate(day: dayDate, currAppDate: currProgressDate)
                    
                    //DAY CELL
                    VStack (spacing:0) {
                        if dayDate != 0 {
                            let thisIsToday = ((dayDate == Int(todayDate.date)) && (currProgressDate.month == todayDate.month) && (currProgressDate.year == todayDate.year))
                            Divider()
                            ZStack(alignment: .center) {
                                Circle()
                                    .foregroundColor(thisIsToday ? .primary4 : .white.opacity(0))
                                
                                if !thisIsToday {
                                    if let d = self.selectedDate {
                                        if vm.dayOfMonth(date: d) == dayDate && (currProgressDate.month == d.month) && (currProgressDate.year == d.year) {
                                            Circle()
                                                .foregroundColor(.white.opacity(0))
                                                .overlay(
                                                    Circle()
                                                        .stroke(.primary4, lineWidth: 2)
                                                )
                                        }
                                    }
                                }
                                
                                Component.DefaultText(text: "\(dayDate)")
                                    .font(.systemBodyText)
                                    .foregroundColor(thisIsToday ? .white : .black)
                            }
                            .frame(width: 32, height: 32)
                            .padding(.top, 12)
                            
                            Circle()
                                .fill(vm.hasNotes(date: currProgressDate, day: dayDate) == .noNotes ? .white.opacity(0) : (vm.hasNotes(date: currProgressDate, day: dayDate) == .filled ? Color.primary1 : Color.gray))
                                .frame(width: 8, height: 8)
                                .padding(.top, 12)
                                .padding(.bottom, 4)
                            Spacer()
                        }
                    }
                    .frame(width: 53) //height:70
                    .onTapGesture {
                        self.selectedDate = vm.getDateFromDayDate(date: currProgressDate, day: dayDate)
                        vm.setSelected(date: currProgressDate, day: dayDate)
                        showSheet.toggle()
                    }
                }
                
            }
            .frame(width: 53*7)
        }
        .onAppear {
            vm.getThisMonthKambuhData(currProgressDate: currProgressDate)
            print(currProgressDate)
        }
        .sheet(isPresented: self.$showSheet) {
            // TODO: what kind of interaction?
            CalendarSheetView(index: $indexKambuh, showSheet: $showSheet, showEditSheet: $showEditSheet, showAddSheet: $showAddSheet)
                .environmentObject(vm)
//                .presentationContentInteraction(.scrolls)
        }
        .sheet(isPresented: self.$showEditSheet, content: {
            CalendarEditSheetView(index: indexKambuh, showSheet: $showSheet, showEditSheet: $showEditSheet)
                .environmentObject(vm)
                .interactiveDismissDisabled()
        })
        .sheet(isPresented: self.$showAddSheet, content: {
            CalendarAddSheetView(showSheet: $showSheet, showAddSheet: $showAddSheet)
                .environmentObject(vm)
                .interactiveDismissDisabled()
        })
    }
}


#Preview {
    CalendarMonthView(currProgressDate: Date(), selectedDate: .constant(nil))
}
