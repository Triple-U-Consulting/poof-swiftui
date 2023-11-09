//
//  HomepageResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 06/11/23.
//

import Foundation

struct HomeDataResponseDTO: Decodable {
    let today: Int
    let week_avg: Double
    let remaining: Int
}

extension HomeDataResponseDTO {
    func toDomain() -> HomeData {
        return .init(today: today, weekAvg: week_avg, remaining: remaining)
    }
}
