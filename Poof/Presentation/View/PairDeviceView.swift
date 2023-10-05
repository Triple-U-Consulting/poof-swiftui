//
//  PairDeviceView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct PairDeviceView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pair Your Inhaler")
                    .font(.systemTitle)
                //image
                Text("Connecting your inhaler helps us collect valuable data about your daily puffs and improving our analysis.")
                    .frame(width: 291, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                
                Component.DefaultButton(text: "Start Pairing")
                Text("Pair Device")
                Button(action: {
                    // Button action goes here
                    //  path = []
                    router.path.append(Page.TabBar)
                }) {
                    Text("Go to App")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.NavigationBackButton(text: "")
                }
                ToolbarItem(placement: .principal) {
                    Text("Pair Your Device")
                        .font(.systemTitle)
                }
            }
        }
    }
}

#Preview {
    PairDeviceView()
        .environmentObject(Router())
}
