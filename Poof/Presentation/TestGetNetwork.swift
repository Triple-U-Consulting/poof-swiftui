//
//  TestGetNetwork.swift
//  Poof
//
//  Created by Angela Christabel on 12/10/23.
//

import SwiftUI

struct TestGetNetwork: View {
    @EnvironmentObject var vm: ViewModel
    @State var pressed: Bool = false
    
    var body: some View {
        switch pressed {
        case false:
            Button(action: {
                vm.fetchKambuh()
                pressed = true
            }, label: {
                Text("Get Kambuh Data")
            })
        case true:
            switch vm.status {
            case .success:
                List(vm.kambuhList) {
                    Text("\($0.start)")
                    Text("\($0.end)")
                    Text("\($0.totalPuff)")
                    Text("\($0.lamaKambuh)")
                }
            case .failure:
                Text("Failed")
            default:
                ProgressView()
            }
        }
    }
}

#Preview {
    TestGetNetwork()
        .environmentObject(ViewModel())
}
