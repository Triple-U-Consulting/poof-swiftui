//
//  ProfileTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 07/11/23.
//

import SwiftUI

struct ProfileTabView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    
    var body: some View {
        Text("Ini Profile")
    }
}

#Preview {
    ProfileTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
