//
//  UserDefaultsController.swift
//  Poof
//
//  Created by Angela Christabel on 18/10/23.
//

import Foundation

protocol UserDefaultController {
    func fetchIsNotFirstLaunch() -> Bool
    func setIsNotFirstLaunch()
    func isOnBoardingDisplayed() -> Bool
    func setIsOnBoardingDisplayed()
}

class UserDefaultsControllerImpl: UserDefaultController {

    static let shared = UserDefaultsControllerImpl(userDefault: UserDefaults())
    let userDefault: UserDefaults
    
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    func fetchIsNotFirstLaunch() -> Bool {
        return userDefault.bool(forKey: "isNotFirst")
    }

    func setIsNotFirstLaunch() {
        userDefault.setValue(true, forKey: "isNotFirst")
    }

    func isOnBoardingDisplayed() -> Bool {
        return userDefault.bool(forKey: "isOnBoardingDisplayed")
    }
    
    func setIsOnBoardingDisplayed() {
        userDefault.set(true, forKey: "isOnBoardingDisplayed")
    }
    
}
