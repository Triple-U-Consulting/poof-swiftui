//
//  ContentView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var vm = ViewModel()
    
    
    var body: some View {
        TestGetNetwork()
            .environmentObject(vm)
//        NavigationStack (path: $router.path) {
//            
//            OnboardingView()
////            TabBarView()
//            .navigationDestination(for: Page.self){ destination in
//                switch destination {
////                case Page.Onboarding:
////                    OnboardingView()
////                        .environmentObject(router)
////                        .navigationBarBackButtonHidden(true)
////                        .environmentObject(vm)
//                case Page.Login:
//                    LoginView()
//                        .environmentObject(router)
//                case Page.PairDevice:
//                    PairDeviceView()
//                        .environmentObject(router)
//                        .navigationBarHidden(true)
//                    
//                case Page.TabBar:
//                    TabBarView()
//                        .environmentObject(router)
//                        .navigationBarHidden(true)
////                        .navigationBarBackButtonHidden(true)
//                default:
//                    VStack {
//                        Text("ada yang error gan")
//                    }
//                }
//            }
//            .onAppear(perform: {
////                router.path.append(1) //somehow gabisa kek gini?
//            })
//        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Router())
}
