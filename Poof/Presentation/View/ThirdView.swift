//
//  ThirdView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct ThirdView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack {
            Button(action: {
                // Button action goes here
                //  path = []
                router.reset()
            }) {
                Text("Go back to root view")
            }
        }
    }
}

#Preview {
    ThirdView()
        .environmentObject(Router())
}
