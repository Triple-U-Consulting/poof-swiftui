//
//  SecondVIew.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI


// INI CONTOH MAKE VIEWMODEL
struct SecondView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
       
            Text("abc")
            Button(action: {
                  router.path.append(2)
              }) {
                  VStack {
//                      Text(vm.name)
                      Text("Go to page 3")
                  }             
            }
        }
}

#Preview {
    SecondView()
        .environmentObject(Router())
        .environmentObject(ViewModel())
}
