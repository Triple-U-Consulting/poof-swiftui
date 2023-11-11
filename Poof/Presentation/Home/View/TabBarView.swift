//
//  TabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var vm: ConditionViewModel = ConditionViewModel()
    @State private var selection = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                InhalerTabView()
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
            .onAppear(perform: {
                vm.fetchKambuhDataIfScaleAndTriggerIsNull()
            })
            .sheet(isPresented: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is Presented@*/.constant(false)/*@END_MENU_TOKEN@*/, content: {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
            })
//            .onAppear() {
//                UITabBar.appearance().tintColor = .yellow
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
