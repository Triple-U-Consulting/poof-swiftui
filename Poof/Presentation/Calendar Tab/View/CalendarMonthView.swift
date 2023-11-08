//
//  CalendarTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/11/23.
//

import SwiftUI

//let dummyDataCaledar: [calendarData] = [.Empty, .Filled]
//    @Binding var progressData: [ProgressModel]
//    @Binding var progressDataByDate: [ProgressModel]

struct CalendarMonthView: View {
    @EnvironmentObject var vm: CalendarViewModel
    
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
                    
                    //fecth data for that cell date
                    
                    //show cigarettes data in box?
                    
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
//                            Circle()
//                                .fill(calendarData[index] == .Empty ? .white.opacity(0) : calendarData[index] == .Unfilled ? Color.gray : Color.primary1)
//                                .frame(width: 8, height: 8)
//                                .padding(.top, 12)
                            Spacer()
                        }
                    }
                    .frame(width: 53, height: 70)
                    .onTapGesture {
                        print("\(Date())")
                        showSheet.toggle()
                        //format date
                        //                            let dateFormatter = DateFormatter()
                        //                            dateFormatter.dateFormat = "dd MMMM yyyy"
                        //                            let itemDateString = dateFormatter.string(from: itemDate)
                        
                        //testing
                        /*print("")
                         print("item date: \(itemDate)")
                         print("date now: \(Date())")
                         print("fill data: \(fillData)")
                         print("cig data: \(cigarettesData)")
                         print("show cig: \(showCigarettes)")
                         print("")
                         print("")
                         */
                        
                        //alert only show for item <= today date
                        //                            if fillData {
                        //                                customAlertTextField(title: itemDateString,
                        //                                                     message: "Number of cigarettes",
                        //                                                     leftButton: "Cancel",
                        //                                                     rightButton: "Save") {
                        //                                    print("Cancelled")
                        //                                } rightAction: { text in
                        
                        //                                    var isDataExist = false
                        
                        //find data to update
                        //                                    for index in progressData.indices {
                        //                                        if progressData[index].date == itemDate {
                        //                                            progressData[index].cigarettes = Int(text)!
                        //                                            isDataExist = true
                        //                                            break
                        //                                        }
                        //                                    }
                        
                        //add new data if there's no record in itemDate
                        //                                    if !isDataExist {
                        //                                        let newData = ProgressModel(date: itemDate, cigarettes: Int(text)!)
                        //                                        progressData.append(newData)
                        //
                        //                                        print("New data saved: \(text) with date \(itemDate)")
                        //                                    }
                        //                                }
                        //                            }
                    }
                }
                
            }
            .frame(width: 53*7)
        }
        .sheet(isPresented: self.$showSheet) {
            CalendarSheetView()
        }
    }
}


#Preview {
    CalendarMonthView(currProgressDate: Date())
        .environmentObject(CalendarViewModel())
}
