//
//  UserDefaultsController.swift
//  Poof
//
//  Created by Angela Christabel on 18/10/23.
//

import Foundation

protocol UserDefaultsController {
    func save(_ data: Any, asKey: String)
    func getString(key: String) -> String?
}

class UserDefaultsControllerImpl {

    static let shared = UserDefaultsControllerImpl(userDefault: UserDefaults.standard)
    let userDefault: UserDefaults
    
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
}

extension UserDefaultsControllerImpl: UserDefaultsController {
    func save(_ data: Any, asKey: String) {
        userDefault.set(data, forKey: asKey)
    }
    
    func getString(key: String) -> String? {
        return userDefault.string(forKey: key)
    }
}
