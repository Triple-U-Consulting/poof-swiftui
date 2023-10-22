//
//  UserRequestDTO+Mapping.swift
//  Poof
//
//  Created by Geraldy Kumara on 19/10/23.
//

import Foundation

struct UserRequestDTO: Encodable {
    let email: String
    let password: String
    let dob: String
    let confirmPassword: String
}
