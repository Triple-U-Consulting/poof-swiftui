//
//  LoginView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack (path: $router.path) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    LoginView()
}
