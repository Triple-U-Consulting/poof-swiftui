//
//  UserRepository.swift
//  Poof
//
//  Created by Angela Christabel on 17/10/23.
//

import Foundation
import Combine

protocol UserRepository {
    //func updateInhalerId(userId: String, id: String) async -> AnyPublisher<Void, Failure>
    func registerUser(email: String, password: String, dob: Date, confirmPassword: String) async -> AnyPublisher<String?, Failure>
}