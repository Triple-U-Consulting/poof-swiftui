//
//  Summary.swift
//  Poof
//
//  Created by Angelica Patricia on 22/11/23.
//

import Foundation

struct Summary: Encodable {
    let labelHighest: String
    let totalUsageHighest: Int
    let labelLowest: String
    let totalUsageLowest: Int
    let highestDaytimeUsage: Int
    let highestNightUsage: Int
    let daysWithoutUsage: Int
}
