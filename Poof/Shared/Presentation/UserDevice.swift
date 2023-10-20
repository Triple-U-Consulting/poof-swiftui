//
//  UserDevice.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 18/10/23.
//

import Foundation
import UIKit

class UserDevice: ObservableObject {
    @Published var topSafeArea: CGFloat = 0
    @Published var bottomSafeArea: CGFloat = 0
    @Published var usableHeight: CGFloat = 0
    @Published var usableWidth: CGFloat = 0
    
    @Published var topSafeAreaWithNavigationBar: CGFloat = 0
    @Published var usableHeightWithNavigationBar: CGFloat = 0
}

//extension UIScreen{
//   static let screenWidth = UIScreen.main.bounds.size.width
//   static let screenHeight = UIScreen.main.bounds.size.height
//   static let screenSize = UIScreen.main.bounds.size
//}
