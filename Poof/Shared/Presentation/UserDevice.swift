//
//  UserDevice.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 18/10/23.
//

import Foundation
import UIKit

class UserDevice: ObservableObject {
    //default iphone 14
    @Published var topSafeArea: CGFloat = 47
    @Published var bottomSafeArea: CGFloat = 34
    @Published var usableHeight: CGFloat = 682
    @Published var usableWidth: CGFloat = 390
    
    @Published var topSafeAreaWithNavigationBar: CGFloat = 91
    @Published var usableHeightWithNavigationBar: CGFloat = 594
    
    @Published var buttonPadding: CGFloat = 24
    @Published var width342: CGFloat = 342
    @Published var height402: CGFloat = 402
}
