//
//  KambuhResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 09/10/23.
//

import Foundation

struct KambuhResponseDTO: Decodable {
    let results: [KambuhDTO]
}

// MARK: - Mappings to Domain

extension KambuhResponseDTO {
    struct KambuhDTO: Decodable {
        let kambuh_id: Int
        let start_time: String
        let end_time: String?
        let total_puff: Int
        let kambuh_interval: String?
        let scale: String?
        let trigger: String?
    }
}

extension KambuhResponseDTO {
    func toDomain() -> [Kambuh] {
        return results.map {
            $0.toDomain()
        }
    }
}

extension KambuhResponseDTO.KambuhDTO {
    func toDomain() -> Kambuh {
        let formatter = DateFormatUtil()
        let startDate = formatter.stringToDate(string: start_time)
        let endDate = end_time != nil ? formatter.stringToDate(string: end_time!) : nil
        let lamaInt = kambuh_interval != nil ? Int64(kambuh_interval!) : nil
        
        return .init(id: kambuh_id, start: startDate, end: endDate, totalPuff: total_puff, lamaKambuh: lamaInt, scale: scale, trigger: trigger)
    }
}
