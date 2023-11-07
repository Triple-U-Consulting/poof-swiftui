//
//  Analytics.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation

struct Analytics: Identifiable {
    let id = UUID()
    let start_date: Date
    let end_date: Date
    let daytimeUsage: Int
    let nightUsage: Int
}
