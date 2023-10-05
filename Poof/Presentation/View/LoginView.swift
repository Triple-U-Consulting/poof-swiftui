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
        VStack {
            Text("Login")
            Button(action: {
                router.path.append(Page.PairDevice)
            }) {
                Text("Go to Pair")
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(Router())
}
