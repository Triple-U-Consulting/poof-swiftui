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
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var wrongPassword: Int = 0
    @State private var wrongEmail:Int = 0
    
    var body: some View {
        
        NavigationView {
            VStack {
                Component.titleSignPage(text: "Email")
                
                TextField(text: $email) {
                    Text(verbatim: "john.doe@gmail.com")
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .padding(.leading, 30)
                .textFieldStyle(.automatic)
                
                Component.dividerSignPage()
                
                Component.titleSignPage(text: "Kata sandi")
                
                SecureField(text: $password) {
                    Text(verbatim: "********")
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .padding(.leading, 30)
                .textFieldStyle(.automatic)
                
                Component.dividerSignPage()
                
                Spacer()
                
                Component.DefaultButton(text: "Sign In") {
                    viewModel.login(email: email, password: password)
                }
                
                Component.bottomSignText(text: "Do not have an account?", blueText: "Sign Up") {
                    router.path.append(Page.Register)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Component.NavigationTitle(text: "Masuk")
                }
            }
//            .navigationDestination(for: Page.self) { _ in
//                RegisterView().environmentObject(router)
//            }
        }
        .padding(8)
    }
}



#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
        .environmentObject(Router())
        .environmentObject(UserDevice())
        .environment(\.locale, .init(identifier: "id"))
}
