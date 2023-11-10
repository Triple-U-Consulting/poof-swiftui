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
    @ObservedObject private var viewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var wrongPassword: Bool = false //untuk nunjukkin alert
    @State private var wrongEmail: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack (spacing:0) {
                Component.titleSignPage(text: "Email")
                
                TextField(text: $email) {
                    Text(verbatim: "john.doe@gmail.com")
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .padding(.leading, 30)
                .textFieldStyle(.automatic)
                .padding(.top, 8)
                
                Component.CustomDivider(width: 342)
                
                Component.titleSignPage(text: "Kata sandi")
                
                SecureField(text: $password) {
                    Text(verbatim: "********")
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .padding(.leading, 30)
                .textFieldStyle(.automatic)
                .padding(.top, 8)
                
                Component.CustomDivider(width: 342)
                
                Spacer()
                
                Text((wrongPassword || wrongEmail) ? "Unable to connect to Wi-Fi. Please recheck SSID and Password" : "")
                    .lineSpacing(-2)
                    .tracking(0.4)
                    .lineLimit(2...2)
                    .font(.systemHeadline)
                    .frame(width: userDevice.width342, alignment: .leading)
                    .foregroundStyle(.red)
                    .padding(.top, 12)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 31)
                
                Component.DefaultButton(text: "Sign In") {
                    viewModel.login(email: "angela@gmail.com", password: "angela")
                }
                .padding(.top, 16)
                .padding(.horizontal, 24)
                
                Component.bottomSignText(text: "Do not have an account?", blueText: "Sign Up") {
                    router.path.append(Page.Register)
                }
                .padding(.top, 40)
                .padding(.bottom, 76 - userDevice.bottomSafeArea)
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
        .onChange(of: viewModel.status, { _, newValue in
            if newValue == .success {
                router.path.append(Page.TabBar)
            }
        })
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
