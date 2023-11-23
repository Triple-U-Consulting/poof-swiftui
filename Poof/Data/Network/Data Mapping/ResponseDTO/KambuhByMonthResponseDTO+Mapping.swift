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
        let end_time: String?
        let total_puff: Int
        let kambuh_interval: String?
        let scale: String?
        let trigger: String?
    }
}

extension KambuhByMonthResponseDTO {
    func toDomain() -> [Int: Kambuh] {
        var temp: [Int: Kambuh] = [:]
        for res in results {
            temp.updateValue(res.toDomain(), forKey: res.getKambuhDay())
        }
        return temp
    }
}

extension KambuhByMonthResponseDTO.KambuhByMonthDTO {
    func toDomain() -> Kambuh {
        let formatter = DateFormatUtil()
        let startDate = formatter.stringToDate(string: start_time)
        let endDate = end_time != nil ? formatter.stringToDate(string: end_time!) : nil
        let lamaInt = kambuh_interval != nil ? Int64(kambuh_interval!) : nil
        
        return .init(id: kambuh_id, start: startDate, end: endDate, totalPuff: total_puff, lamaKambuh: lamaInt, scale: scale, trigger: trigger)
    }
    
    func getKambuhDay() -> Int {
        let formatter = DateFormatUtil.shared
        let startDate = formatter.stringToDate(string: start_time)
        
        return formatter.getDay(date: startDate)
    }
}
