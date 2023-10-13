//
//  DateFormatUtil.swift
//  Poof
//
//  Created by Angela Christabel on 13/10/23.
//

import Foundation

class DateFormatUtil {
    lazy var formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return df
    }()
    
    func stringToDate(string: String) -> Date {
        return formatter.date(from: string)!
    }
}
