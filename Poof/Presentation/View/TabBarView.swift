//
//  TabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var router: Router
    @State private var selection = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                InhalerTabView()
                    .tabItem {
                        Image(systemName: "lungs.fill")
                        Text("Inhaler")
                    }
                    .tag(0)
                
                SummaryTabView()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard.fill")
                        Text("Summary")
                    }
                    .tag(1)
                
                RecommendationTabView()
                    .tabItem {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("Reccomendation")
                    }
                    .tag(2)
            }
            .accentColor(Color.Main.primary)
//            .onAppear() {
//                UITabBar.appearance().barTintColor = .red
//                UITabBar.appearance().layer.borderColor = UIColor(.gray).cgColor
//            }
        }
    }
}
    
#Preview {
    TabBarView()
        .environmentObject(Router())
    
}
