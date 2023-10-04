//
//  ContentView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
//    @State private var currentPage = Page.InhalerTab
//    @State private var selection = 0
    @StateObject var vm = ViewModel(name: "jovan")
    
    
    
    var body: some View {
        
        NavigationStack (path: $router.path) {
            
            Button(action: {
                router.path.append(3)
            }) {
                VStack {
                    Text("Go to page 1")
                    Text(vm.name)
                }
            }
            .navigationDestination(for: Int.self){ destination in
                switch destination {
                case 1:
                    SecondView()
                        .environmentObject(router)
                        .environmentObject(vm)
                case 2:
                    ThirdView().environmentObject(router)
                case 3:
                    TabBarView().environmentObject(router)
                        .navigationBarHidden(true)
                default:
                    EmptyView()
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Router())
}
