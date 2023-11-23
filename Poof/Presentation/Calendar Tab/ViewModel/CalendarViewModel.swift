//
//  CalendarHelper.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/10/23.
//

import Foundation
import Combine

enum NoteStatus: Int8 {
    case noNotes = 0
    case needsToBeFilled = 1
    case filled = 2
}

class CalendarViewModel: ObservableObject {
    @Published var processedKambuhData: [Date: [Kambuh]]
    @Published var monthsInCalendar: [Date]
    @Published var message: String = ""
    
    // MARK: - Sheet view
    @Published private(set) var currentDateSelected: Date
    
    private(set) var calendar = Calendar.current
    
    // MARK: - Usecases
    private let getKambuhByMonth: GetKambuhByMonthUsecase
    private let updateConditionKambuh: UpdateKambuhConditionUseCase
    private let deleteKambuhData: DeleteKambuhDataUseCase
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    init(
        processedKambuhData: [Date: [Kambuh]] = [:],
        monthsInCalendar: [Date] = [],
        currentDateSelected: Date = Date(),
        calendar: Calendar = Calendar.current,
        getKambuhByMonth: GetKambuhByMonthUsecase = GetKambuhByMonthImpl.shared,
        updateConditionKambuh: UpdateKambuhConditionUseCase = UpdateKambuhConditionImpl.shared,
        deleteKambuhData: DeleteKambuhDataUseCase = DeleteKambuhDataImpl.shared
    ) {
        self.processedKambuhData = processedKambuhData
        self.monthsInCalendar = monthsInCalendar
        self.currentDateSelected = currentDateSelected
        self.calendar = calendar
        self.getKambuhByMonth = getKambuhByMonth
        self.updateConditionKambuh = updateConditionKambuh
        self.deleteKambuhData = deleteKambuhData
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
                    
                    if groupedKambuhData.count > 0 {
                        DispatchQueue.main.async {
                            self.processedKambuhData = groupedKambuhData
                        }
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    func updateKambuhData() {
        Task {
            await updateConditionKambuh.execute(kambuh: self.processedKambuhData.values.flatMap{ $0 })
                .sink { completion in
                    switch completion{
                    case .finished:
                        print(completion)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                } receiveValue: { result in
                    print(result)
                }
                .store(in: &cancellables)
        }
    }
}

// MARK: - Actions
extension CalendarViewModel {
    // CalendarTabView
    func initMonthsInCalendar() {
        var monthsInCalendar: [Date] = []
        var refMonth = calendar.date(from: DateComponents(year: 1970, month: 1, day: 1))!
        let today = Date.now
        
        while today.compare(refMonth) == .orderedDescending {
            let pastMonth = calendar.date(byAdding: .month, value: 1, to: refMonth)!
            monthsInCalendar.append(refMonth)
            refMonth = pastMonth
        }
                 
        self.monthsInCalendar = monthsInCalendar
    }
    
    func addMoreMonths(_ placement: String, n: Int = 1) {
        if placement == "prev" {
            for _ in 0..<n {
                let prev = self.plusMonth(date: self.monthsInCalendar.first!, value: -1)
                self.monthsInCalendar.insert(prev, at: 0)
            }
        } else {
            for _ in 0..<n {
                let last = self.plusMonth(date: self.monthsInCalendar.last!, value: 1)
                self.monthsInCalendar.append(last)
            }
        }
    }
    
    // CalendarMonthView
    func getDateFromDayDate(date: Date, day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.year = calendar.component(.year, from: date)
        
        return calendar.date(from: dateComponents)!
    }
    
    func setSelected(date: Date, day: Int) {
        self.currentDateSelected = getDateFromDayDate(date: date, day: day)
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
    
    // CalendarSheetView
    func getDateKeys() -> [Date] {
        return self.processedKambuhData.keys.sorted{ $0 < $1 }
    }
    
    func getKambuhByDate(date: Date) -> [Kambuh] {
        return self.processedKambuhData[date] ?? []
    }
    
    func getCurrentKambuhTotalPuff(idx: Int) -> Int {
        guard self.processedKambuhData[self.currentDateSelected] != nil else { return 0 }
        
        return self.processedKambuhData[self.currentDateSelected]![idx].totalPuff
    }
    
    func getCurrentKambuhScale(idx: Int) -> String {
        guard self.processedKambuhData[self.currentDateSelected] != nil else { return "No data recorded" }
        
        return self.processedKambuhData[self.currentDateSelected]![idx].scale == nil ? "No data recorded" : "\(self.processedKambuhData[self.currentDateSelected]![idx].scale!) points of breathing difficulty"
    }
    
    func getCurrentKambuhTime(idx: Int) -> String {
        guard self.processedKambuhData[self.currentDateSelected] != nil else { return "No data recorded" }
        
        return DateFormatUtil.shared.dateToString(date: self.processedKambuhData[self.currentDateSelected]![idx].start, to: "HH.mm")
    }
    
    // CalendarEditSheetView
    func getCurrentKambuh(index: Int) -> Kambuh {
        return self.processedKambuhData[self.currentDateSelected]![index]
    }
}

// MARK: - Helper functions
extension CalendarViewModel {
    func getDateFromMonthYear(month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = month
        dateComponents.year = year
        
        let itemCalendar = Calendar(identifier: .gregorian)
        return itemCalendar.date(from: dateComponents)!
    }
    
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
        return calendar.component(.weekday, from: firstOfMonthDate) - 1
    }
    
    
    func showCalendarData(currProgressDate: Date) -> [Int] {
        var daysData: [Int] = []
        
        //April contains 30 days (Int)
        let totalDays = totalDaysInMonth(date: currProgressDate)
        
        //1 April = 6 (Saturday, means we want to empty space from sun to fri)
        let startingSpace = firstWeekDayOfMonth(date: currProgressDate)
        
        var ctrItem: Int = 1
        //empty space have 42 box
        print(startingSpace)
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



//extension Date {
//    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
//        return calendar.dateComponents(Set(components), from: self)
//    }
//
//    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
//        return calendar.component(component, from: self)
//    }
//}


extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
    static let month: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    static let year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    static let hourMinute: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static let fullDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let fullTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }()
}

extension CalendarViewModel {
    func deleteKambuhData(index: Int){
        
        let kambuh_id = getCurrentKambuh(index: index)
        
        Task {
            await deleteKambuhData.execute(kambuh_id: kambuh_id.id)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Deletted item")
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { message in
                    print(message)
                    self.message = message
                }
                .store(in: &cancellables)
        }
    }
}

extension Date {
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
    var hour12:  String      { return Formatter.hour12.string(from: self) }
    var minute0x: String     { return Formatter.minute0x.string(from: self) }
    var amPM: String         { return Formatter.amPM.string(from: self) }
    var month: String        { return Formatter.month.string(from: self) }
    var date: String         { return Formatter.date.string(from: self) }
    var year: String         { return Formatter.year.string(from: self) }
    var hourMinute: String   { return Formatter.hourMinute.string(from: self) }
    var fullDateTime: String   { return Formatter.fullDateTime.string(from: self) }
    var fullDate: String   { return Formatter.fullDate.string(from: self) }
    var fullTime: String   { return Formatter.fullTime.string(from: self) }


}
