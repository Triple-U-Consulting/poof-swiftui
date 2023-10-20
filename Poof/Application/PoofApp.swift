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
    @StateObject var userDevice = UserDevice()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(userDevice)
        }
    }
}
