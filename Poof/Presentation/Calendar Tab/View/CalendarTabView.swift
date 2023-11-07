//
//  CalendarTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/11/23.
//

import SwiftUI

//struct CalendarTabView: UIViewRepresentable {
//    let interval: DateInterval
//
//    func makeUIView(context: Context) -> UICalendarView {
//        let view = UICalendarView()
//        view.calendar = Calendar(identifier: .gregorian)
//        view.availableDateRange = interval
//        return view
//    }
//
//    func updateUIView(_ uiView: UICalendarView, context: Context) {
//        //logic
//    }
//
//}


struct CalendarTabView: View {
    let columns = Array(repeating: GridItem(spacing: 0), count:7)
    let weekDaysData: [String] = ["S", "S", "R", "K", "J", "S", "M"]
    let currProgressDate = Date()
    @State var daysData: [String] = []
    @State private var showSheet = false
    //    @Binding var progressData: [ProgressModel]
    //    @Binding var progressDataByDate: [ProgressModel]
    
    var body: some View {
        Text("Calendar")
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
            ForEach(0..<3, id:\.self) { index in
                //Month & Year
                HStack {
                    Text(CalendarHelper.shared
                        .getCalendarComponentString(date: CalendarHelper.shared.plusMonth(date: currProgressDate, value: index), format: "LLLL")
                    )
//                    Text(CalendarHelper.shared
//                        .getCalendarComponentString(date: CalendarHelper.shared.plusMonth(date: currProgressDate, value: index), format: "YYYY")
//                    )
                }
                .frame(width: 200)
                
                //MARK: Calendar Data
                LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                    //MARK: Day Cell
                    ForEach(daysData.indices, id:\.self) {x in
                        
                        let boxItem = daysData[x]
                        
                        //get the current item date (1 is random number that I generate to handle error in empty boxItem)
                        let itemDate = CalendarHelper().getItemDate(day: Int(boxItem) ?? 1, currAppDate: currProgressDate)
                        
                        //get cigarettes data from itemDate
                        //                    let cigarettesData: Int = CalendarHelper().findCigInProgressData(itemDate: itemDate, progressData: progressData)
                        let cigarettesData: Int = 5
                        
                        //show cigarettes data in box
                        let showCigarettes: Bool = (cigarettesData != -1) ? true : false
                        
                        //used to block input from user in date greater than today
                        let fillData: Bool = itemDate <= Date()
                        
                        let isUserUseInhaler: Bool = true
                        let isFormFilled: Bool = false
                        
                        //DAY CELL
                        VStack (spacing:0) {
                            if boxItem == "" {
                                
                            } else {
                                Divider()
                                Component.DefaultText(text: boxItem)
                                    .font(.systemBodyText)
                                    .padding(.top, 12)
                                //Indicator whether the user use inhaler that day
                                Circle()
                                    .fill(isUserUseInhaler ? isFormFilled ? Color.black : Color.gray : .white.opacity(0))
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 12)
                                Spacer()
                            }
                        }
                        .frame(width: 53, height: 70)
                        .onTapGesture {
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
        }
        .sheet(isPresented: self.$showSheet) {
            CalendarSheetView()
        }
        .onAppear {
            daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
        }
    }
}

#Preview {
    CalendarView()
}
