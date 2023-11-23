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
    let end: Date?
    let totalPuff: Int
    let lamaKambuh: Int64?
    var scale: String?
    var trigger: String?
}

extension Kambuh {
    func hasNotes() -> Bool {
        return ((scale == nil || scale == "Pilih") && (trigger == nil || trigger == "Choose")) ? false : true
    }
}
