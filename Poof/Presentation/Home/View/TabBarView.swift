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
                        Image(systemName: "lungs.fill")
                        Text("Obat")
                    }
                    .tag(0)
                
                CalendarTabView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Kalender")
                    }
                    .tag(1)
                
                AnalyticsFilterView()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard.fill")
                        Text("Ringkasan")
                    }
                    .tag(2)
                
                ProfileTabView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
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
