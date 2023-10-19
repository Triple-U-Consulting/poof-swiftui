//
//  DateFormatUtil.swift
//  Poof
//
//  Created by Angela Christabel on 13/10/23.
//

import Foundation

class DateFormatUtil {
    
    static let shared = DateFormatUtil()
    
    func dateToString(date: Date, to format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        
        let str = df.string(from: date)
        
        return str
    }
    
    // for full date + time
    lazy var formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return df
    }()
    
    func stringToDate(string: String) -> Date {
        return formatter.date(from: string)!
    }
    
    // day only
    lazy var formatterDayOnly = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    func stringToDateOnly(string: String) -> Date{
        return formatterDayOnly.date(from: string)!
    }
}
