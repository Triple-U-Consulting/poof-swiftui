//
//  TestGetNetwork.swift
//  Poof
//
//  Created by Angela Christabel on 12/10/23.
//

import SwiftUI

struct TestGetNetwork: View {
    @EnvironmentObject var vm: AuthViewModel
    @State var pressed: Bool = false
    
    var body: some View {
        VStack {
            switch vm.status {
            case .initial:
                Button(action: {
                    vm.login(email: "angela@gmail.com", password: "angela")
    //                vm.fetchKambuh()
    //                pressed = true
                }, label: {
                    Text("Login")
                })
                
                Button {
//                    vm.findInhaler()
                } label: {
                    Text("Pair inhaler")
                }
            case .loading:
                ProgressView()
            case .success:
                Button {
//                    vm.updateUserInhalerId()
                } label: {
                    Text("Update user inhaler")
                }
            case .failure:
                Text("Failed")
            }
        }
    }
}

#Preview {
    TestGetNetwork()
        .environmentObject(ViewModel())
}
