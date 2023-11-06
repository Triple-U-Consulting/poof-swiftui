//
//  ConditionRequest.swift
//  Poof
//
//  Created by Geraldy Kumara on 06/11/23.
//

import Foundation

struct ConditionRequestDTO: Encodable{
    let allValuetoUpdate: [ConditionKambuh]
}

extension ConditionRequestDTO{
    struct ConditionKambuh: Encodable{
        let kambuh_id: Int
        let scale: Int
        let trigger: Bool
    }
}
