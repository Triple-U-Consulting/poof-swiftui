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
    @State private var indexKambuh = 0
    
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
                            .font(.systemSubheader)
                            .textCase(.uppercase)
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
                            Divider()
                            Component.DefaultText(text: "\(dayDate)")
                                .font(.systemBodyText)
                                .padding(.top, 12)
                            //Indicator whether the user use inhaler that day
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
            CalendarSheetView(index: $indexKambuh, showSheet: $showSheet, showEditSheet: $showEditSheet)
                .environmentObject(vm)
        }
        .sheet(isPresented: self.$showEditSheet, content: {
            CalendarEditSheetView(index: indexKambuh, showSheet: $showEditSheet)
                .environmentObject(vm)
        })
    }
}


#Preview {
    CalendarMonthView(currProgressDate: Date())
}
