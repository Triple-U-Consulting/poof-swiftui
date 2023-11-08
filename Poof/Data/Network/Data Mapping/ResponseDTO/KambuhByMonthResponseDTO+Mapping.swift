//
//  KambuhByMonthResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 08/11/23.
//

import Foundation

struct KambuhByMonthResponseDTO: Decodable {
    let results: [KambuhByMonthDTO]
}

extension KambuhByMonthResponseDTO {
    struct KambuhByMonthDTO: Decodable {
        let kambuh_id: Int
        let start_time: String
        let end_time: String
        let total_puff: Int
        let kambuh_interval: String
        let scale: Int?
        let trigger: Bool?
    }
}

extension KambuhByMonthResponseDTO {
    func toDomain() -> [Int: Kambuh] {
        var temp: [Int: Kambuh] = [:]
        var keys = results.map {
            temp.updateValue($0, forKey: $0.)
        }
    }
}

extension KambuhByMonthResponseDTO.KambuhByMonthDTO {
    func toDomain() -> Int {
        let formatter = DateFormatUtil.shared
        let startDate = formatter.stringToDate(string: start_time)
        
        return formatter.getDay(date: startDate)
    }
}
