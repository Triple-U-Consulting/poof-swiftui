//
//  LoginView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Color.clear
                    .position(CGPoint(x: 0, y: 0))
                    .onAppear {
                        DispatchQueue.main.async {
                            userDevice.topSafeAreaWithNavigationBar = geo.safeAreaInsets.top
                            userDevice.usableHeightWithNavigationBar = geo.size.height - userDevice.topSafeAreaWithNavigationBar - userDevice.bottomSafeArea
                        }
                    }
            }
            .environmentObject(userDevice)
            
            VStack {
                Text("Login")
                Button(action: {
                    print("Top NB: \(userDevice.topSafeAreaWithNavigationBar)")
                    print("Height NB: \(userDevice.usableHeightWithNavigationBar)")
                    router.path.append(Page.PairDevice)
                }) {
                    Text("Go to Pair")
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
