//
//  AnalyticsMapping.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation

struct AnalyticsResponseDTO: Decodable {
    let results: [AnalyticsDTO]
}

// MARK: - Mappings to Domain

extension AnalyticsResponseDTO {
    struct AnalyticsDTO: Decodable {
        let label: String
        let start_date: String
        let end_date: String
        let daytime_usage: String
        let night_usage: String
    }
}

extension AnalyticsResponseDTO {
    func toDomain() -> [Analytics] {
        return results.map {
            $0.toDomain()
        }
    }
}

extension AnalyticsResponseDTO.AnalyticsDTO {
    func toDomain() -> Analytics {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let startDate = dateFormatter.date(from: self.start_date) ?? Date()
        let endDate = dateFormatter.date(from: self.end_date) ?? Date()
        let daytimeUsage = Int(self.daytime_usage) ?? 0
        let nightUsage = Int(self.night_usage) ?? 0
        return Analytics(label: label, start_date: startDate, end_date: endDate, daytimeUsage: daytimeUsage, nightUsage: nightUsage)
    }
}
