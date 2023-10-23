//
//  ContentView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @StateObject var vm = ViewModel()
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Color.clear
                    .position(CGPoint(x: 0, y: 0))
                    .onAppear {
                        userDevice.topSafeArea = geo.safeAreaInsets.top
                        userDevice.bottomSafeArea = geo.safeAreaInsets.bottom
                        userDevice.usableHeight = geo.size.height - userDevice.topSafeArea - userDevice.bottomSafeArea
                        userDevice.usableWidth = geo.size.width

                        print("Init Bot: \(userDevice.bottomSafeArea)")
                        print("Init Top: \(userDevice.topSafeArea)")
                        print("Init Height: \(userDevice.usableHeight)")
                        print("Init Width: \(userDevice.usableWidth)")
                    }
            }
            .environmentObject(userDevice)
            
            NavigationStack (path: $router.path) {
                OnboardingView()
                    .navigationDestination(for: Page.self){ destination in
                        switch destination {
                            //                        case Page.Onboarding:
                            //                            OnboardingView()
                            //                                .environmentObject(router)
                            //                                .navigationBarBackButtonHidden(true)
                            //                                .environmentObject(vm)
                        case Page.Login:
                            LoginView()
                                .environmentObject(router)
                                .navigationBarHidden(true)
                        case Page.Register:
                            RegisterView()
                                .environmentObject(router)
                                .navigationBarHidden(true)
                        case Page.PairDevice:
                            PairDeviceView()
                                .environmentObject(router)
                                .navigationBarHidden(true)
                        case Page.TabBar:
                            TabBarView()
                                .environmentObject(router)
                                .navigationBarHidden(true)
                            //                                .navigationBarBackButtonHidden(true)
                        default:
                            VStack {
                                Text("ada yang error gan")
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
