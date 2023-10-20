//
//  PoofApp.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

@main
struct PoofApp: App {
    @StateObject var router = Router()
    var body: some Scene {
        WindowGroup {
            WiFiDetailsView()
                .environmentObject(router)
        }
    }
}
