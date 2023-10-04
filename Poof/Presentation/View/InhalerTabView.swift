//
//  InhalerTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct InhalerTabView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Component.RotatingCircle()
                    //                Component.RotatingGradientCircle()
                    Component.CircleButton(text: "SYNC", diameter: 213)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.NavigationTitle(text: "Inhaler")
                        .padding(.top, 16)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Component.ProfileButton(text: "")
                        .padding(.top, 16)
                }
            }
//            .navigationTitle("Inhaler")
//            .navigationBarHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(8)
    }
}

#Preview {
    InhalerTabView()
        .environmentObject(Router())
    
}
