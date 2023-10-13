//
//  OnboardingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("Onboarding")
            Button(action: {
                router.path.append(Page.Login)
            }) {
                Text("Go to login")
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Router())
}
