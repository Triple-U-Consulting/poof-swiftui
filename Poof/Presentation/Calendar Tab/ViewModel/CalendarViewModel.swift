//
//  CalendarHelper.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/10/23.
//

import Foundation

enum NoteStatus: Int8 {
    case noNotes = 0
    case needsToBeFilled = 1
    case filled = 2
}

class CalendarViewModel: ObservableObject {
    @Published private(set) var processedKambuhData: [Date: [Kambuh]]
    
    // MARK: - Sheet view
    @Published private(set) var currentDateSelected: Date?
    
    // MARK: - Sheet detail view
    @Published private(set) var shownKambuhData: [Kambuh]
    
    private(set) var calendar = Calendar.current
    
    // MARK: - Usecases
    private let getKambuhByMonth: GetKambuhByMonthUsecase
    
    init(
        processedKambuhData: [Date: [Kambuh]] = [:],
        currentDateSelected: Date? = nil,
        shownKambuhData: [Kambuh] = [],
        calendar: Foundation.Calendar = Calendar.current,
        getKambuhByMonth: GetKambuhByMonthUsecase = GetKambuhByMonthImpl.shared
    ) {
        self.processedKambuhData = processedKambuhData
        self.currentDateSelected = currentDateSelected
        self.shownKambuhData = shownKambuhData
        self.calendar = calendar
        self.getKambuhByMonth = getKambuhByMonth
    }
}

// MARK: - Usecases
extension CalendarViewModel {
    func getThisMonthKambuhData(currProgressDate date: Date) {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.year = calendar.component(.year, from: date)
        
        let date = calendar.date(from: dateComponents)!
        
        Task {
            await self.getKambuhByMonth.execute(date: date)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                } receiveValue: { results in
                    let groupedKambuhData = Dictionary(grouping: results) { kambuh in
                        self.calendar.startOfDay(for: kambuh.start)
                    }
                    
                    DispatchQueue.main.async {
                        self.processedKambuhData = groupedKambuhData
                    }
                }
        }
    }
}

// MARK: - Actions
extension CalendarViewModel {
    func setSelected(date: Date, day: Int) {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.year = calendar.component(.year, from: date)
        
        self.currentDateSelected = calendar.date(from: dateComponents)!
        self.shownKambuhData = self.processedKambuhData[self.currentDateSelected!] ?? []
    }
    
    func getRequestedKambuh(index: Int) -> Kambuh {
        return shownKambuhData[index]
    }
    
    func hasNotes(date: Date, day: Int) -> NoteStatus {
        var components = DateComponents()
        components.day = day
        components.month = calendar.component(.month, from: date)
        components.year = calendar.component(.year, from: date)
        
        let finalDate = calendar.startOfDay(for: calendar.date(from: components)!)
        
        guard let kambuhArray = self.processedKambuhData[finalDate] else { return .noNotes }
        
        for kambuh in kambuhArray {
            if !kambuh.hasNotes() {
                return .needsToBeFilled
            }
        }
        
        return .filled
    }
}

// MARK: - Helper functions
extension CalendarViewModel {
    func getCellDate(day: Int, currAppDate: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = calendar.component(.month, from: currAppDate)
        dateComponents.year = calendar.component(.year, from: currAppDate)
        dateComponents.hour = calendar.component(.hour, from: currAppDate)
        dateComponents.minute = calendar.component(.minute, from: currAppDate)
        dateComponents.timeZone = TimeZone(identifier: "id-ID")
        
        let itemCalendar = Calendar(identifier: .gregorian)
        return itemCalendar.date(from: dateComponents)!
    }
    
    func plusMonth(date: Date, value: Int) -> Date {
        return calendar.date(byAdding: .month, value: value, to: date)!
    }

//    func minusMonth(date: Date) -> Date {
//        return calendar.date(byAdding: .month, value: -1, to: date)!
//    }
    
    //full month = LLLL, year = yyyy
    func getCalendarComponentString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func totalDaysInMonth(date: Date) -> Int {
        let days = calendar.range(of: .day, in: .month, for: date)!
        return days.count
    }
    
    //ex output from: 2 jan 2021 -> 2
    func dayOfMonth(date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    func firstWeekDayOfMonth(date: Date) -> Int {
        let component = calendar.dateComponents([.year, .month], from: date)
        let firstOfMonthDate = calendar.date(from: component)!
        return calendar.component(.weekday, from: firstOfMonthDate) - 2
    }
    
//    func showStatLastSevenDays(progressData: [ProgressModel]) -> [ProgressModel] {
//        var progressDataByDate: [ProgressModel] = []
//        let sevenDaysInt = Calendar.current.component(.day, from: Date()) - 7
//        let sevenDaysAgoDate = CalendarHelper().getItemDate(day: sevenDaysInt, currAppDate: Date())
//
//        for data in progressData {
//            if data.date >= sevenDaysAgoDate && data.date <= Date() {
//                progressDataByDate.append(data)
//            }
//        }
//        return progressDataByDate
//    }
    
//    func showStatThisMonth(progressData: [ProgressModel]) -> [ProgressModel] {
//        var progressDataByDate: [ProgressModel] = []
//        let currMonth = Calendar.current.component(.month, from: Date())
//        let currYear = Calendar.current.component(.year, from: Date())
//
//        for data in progressData {
//            let dataMonth = Calendar.current.component(.month, from: data.date)
//            let dataYear = Calendar.current.component(.year, from: data.date)
//
//            if dataMonth == currMonth && dataYear == currYear {
//                progressDataByDate.append(data)
//            }
//        }
//        return progressDataByDate
//    }
    
    func showCalendarData(currProgressDate: Date) -> [Int] {
        var daysData: [Int] = []
        
        //April contains 30 days (Int)
        let totalDays = totalDaysInMonth(date: currProgressDate)
        
        //1 April = 6 (Saturday, means we want to empty space from sun to fri)
        let startingSpace = firstWeekDayOfMonth(date: currProgressDate)
        
        var ctrItem: Int = 1
        //empty space have 42 box
        while(ctrItem <= 42) {
            if ctrItem <= startingSpace || (ctrItem - startingSpace) > totalDays {
                daysData.append(0)
            } else {
                daysData.append(ctrItem - startingSpace)
            }
            
            ctrItem += 1
        }
        return daysData
    }
}
