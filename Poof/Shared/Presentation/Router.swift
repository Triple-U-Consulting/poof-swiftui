//
//  Router.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset(){
        self.path = NavigationPath()
    }
}

enum Page {
    case PrivacyPolicy
    case TermsAndCondition
    case Onboarding
    case Login
    case Register
    case PairDevice
    case WifiConfig
    case TabBar
    case InputDose 
    case InputTrigger
}
