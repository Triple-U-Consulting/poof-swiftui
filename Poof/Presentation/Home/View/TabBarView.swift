//
//  TabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @State private var selection = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                InhalerTabView()
                    .environmentObject(router)
                    .environmentObject(userDevice)
                    .tabItem {
                        Image("tabBarIcon1")
                            .renderingMode(.template)
                        Text("Airo")
                    }
                    .tag(0)
                
                CalendarTabView()
                    .tabItem {
                        Image("tabBarIcon2")
                            .renderingMode(.template)
                        Text("Kalender")
                    }
                    .tag(1)
                
                AnalyticsFilterView()
                    .tabItem {
                        Image("tabBarIcon3")
                            .renderingMode(.template)
                        Text("Analitik")
                    }
                    .tag(2)
                
                ProfileTabView()
                    .tabItem {
                        Image("tabBarIcon4")
                            .renderingMode(.template)
                        Text("Profil")
                    }
                    .tag(3)
                
            }
            .accentColor(Color.Main.primary1)
        }
    }
}
    
#Preview {
    TabBarView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
    
}
