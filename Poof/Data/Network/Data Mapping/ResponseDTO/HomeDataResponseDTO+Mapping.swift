//
//  HomepageResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 06/11/23.
//

import Foundation

struct HomeDataResponseDTO: Decodable {
    let today: Int
    let weekAvg: Double
    let remaining: Int
}

extension HomeDataResponseDTO {
    func toDomain() -> HomeData {
        return .init(today: today, weekAvg: weekAvg, remaining: remaining)
    }
}
