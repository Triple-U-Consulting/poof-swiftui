//
//  CalendarTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/11/23.
//

import SwiftUI

struct CalendarMonthView: View {
    @ObservedObject var vm = CalendarViewModel()
    
    let columns = Array(repeating: GridItem(spacing: 0), count:7)
    let currProgressDate: Date
    
    @State var dayDates: [Int] = []
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            //Month
            HStack {
                Text(vm.getCalendarComponentString(date: vm.plusMonth(date: currProgressDate, value: 0), format: "LLLL")
                )
                .onAppear {
                    DispatchQueue.main.async {
                        dayDates = vm.showCalendarData(currProgressDate: currProgressDate)
                    }
                }
            }
            
            //Calendar Data
            LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                
                //Day Cell
                ForEach(dayDates.indices, id:\.self) {index in
                    let dayDate = dayDates[index] //["","",1,2,3,4,5,...]
                    
                    //get the current cell date (1 is random number that I generate to handle error in empty boxItem)
                    let cellDate = vm.getCellDate(day: dayDate, currAppDate: currProgressDate)
                    
                    //used to block input from user in date greater than today
//                    let fillData: Bool = cellDate <= Date()
                    
                    //DAY CELL
                    VStack (spacing:0) {
                        if dayDate != 0 {
                            Divider()
                            Component.DefaultText(text: "\(dayDate)")
                                .font(.systemBodyText)
                                .padding(.top, 12)
                            //Indicator whether the user use inhaler that day
                            Circle()
                                .fill(vm.monthKambuhData[dayDate] == nil ? .white.opacity(0) : (vm.monthKambuhData[dayDate]!.hasNotes() ? Color.primary1 : Color.gray))
                                .frame(width: 8, height: 8)
                                .padding(.top, 12)
                            Spacer()
                        }
                    }
                    .frame(width: 53, height: 70)
                    .onTapGesture {
                        print("\(Date())")
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
            CalendarSheetView()
        }
    }
}


#Preview {
    CalendarMonthView(currProgressDate: Date())
}
