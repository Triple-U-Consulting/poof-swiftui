//
//  User.swift
//  Poof
//
//  Created by Geraldy Kumara on 19/10/23.
//

import Foundation

struct User: Encodable{
    let email: String
    let password: String
    let dob: Date?
}
