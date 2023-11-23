//
//  KambuhRequestDTO.swift
//  Poof
//
//  Created by Angelica Patricia on 23/11/23.
//

import Foundation

struct KambuhRequestDTO: Encodable {
    let start_time: String
    let total_puff: Int
    let scale: String
    let trigger: String
}
