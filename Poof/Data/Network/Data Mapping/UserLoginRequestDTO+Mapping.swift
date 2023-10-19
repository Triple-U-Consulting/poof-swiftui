//
//  UserLoginRequestDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation

struct UserLoginRequestDTO: Encodable {
    let email: String
    let password: String
}
