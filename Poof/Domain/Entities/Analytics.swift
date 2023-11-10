//
//  Analytics.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation

struct Analytics: Identifiable {
    let id = UUID()
    let label: String
    let start_date: Date
    let end_date: Date
    let daytimeUsage: Int
    let nightUsage: Int
}

enum Frequency: String, CaseIterable, Identifiable {
    case week = "week"
    case month = "month"
    case quarter = "quarter"
    case halfyear = "halfyear"
//    case year = "year"
    
    var id: String { self.rawValue }
}
