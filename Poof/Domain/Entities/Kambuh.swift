//
//  Kambuh.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation

struct Kambuh: Identifiable {
    let id: Int
    let start: Date
    let end: Date
    let totalPuff: Int
    let lamaKambuh: Int64
    var scale: Int?
    var trigger: Bool?
}

extension Kambuh {
    func hasNotes() -> Bool {
        return (scale == nil && trigger == nil) ? false : true
    }
}
