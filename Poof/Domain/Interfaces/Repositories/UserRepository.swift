//
//  File.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation
import Combine

protocol UserRepository {
    func login(email: String, password: String) async -> AnyPublisher<String?, Failure>
//    func updateInhalerId(id: String, userToken: String) async -> AnyPublisher<User, Failure>
}
