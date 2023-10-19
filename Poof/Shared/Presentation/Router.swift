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
    case Register
    case Onboarding
    case Login
    case PairDevice
    case TabBar
}
