//
//  SummaryResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angelica Patricia on 22/11/23.
//

import Foundation

struct SummaryResponseDTO: Decodable {
    let results: [SummaryDTO]
}

// MARK: - Mappings to Domain

extension SummaryResponseDTO {
    struct SummaryDTO: Decodable {
        let label_highest_usage: String
        let total_usage_highest: Int
        let label_lowest_usage: String
        let total_usage_lowest: Int
        let highest_daytime_usage: Int
        let highest_night_usage: Int
        let total_days_without_usage: Int
    }
}

extension SummaryResponseDTO {
    func toDomain() -> [Summary] {
        return results.map {
            $0.toDomain()
        }
    }
}

extension SummaryResponseDTO.SummaryDTO {
    func toDomain() -> Summary {
        return Summary(labelHighest: label_highest_usage, totalUsageHighest: total_usage_highest, labelLowest: label_lowest_usage, totalUsageLowest: total_usage_lowest, highestDaytimeUsage: highest_daytime_usage, highestNightUsage: highest_night_usage, daysWithoutUsage: total_days_without_usage)
    }
}
