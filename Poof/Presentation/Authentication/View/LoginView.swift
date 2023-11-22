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
            ZStack {
                VStack (spacing:0) {
                    VStack {
                        Component.titleSignPage(text: "Email")
                        
                        TextField(text: $email) {
                            Text(verbatim: "loremipsum@gmail.com")
                        }
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .padding(.top, 8)
                        
                        Component.CustomDivider(width: 342)
                        
                        Component.titleSignPage(text: "Kata sandi")
                        
                        SecureField(text: $password) {
                            Text(verbatim: "Ketik Kata Sandi Anda")
                        }
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .padding(.top, 8)
                        
                        Component.CustomDivider(width: 342)
                    }
                    .padding(8)
                    
                    Spacer()
                    
    //                Text((wrongPassword || wrongEmail) ? "Unable to connect to Wi-Fi. Please recheck SSID and Password" : "")
                    Component.DefaultText(text: (wrongPassword || wrongEmail) ? "Email atau kata sandi yang dimasukkan salah." : "", textAlignment: .leading)
                        .lineLimit(2...2)
                        .font(.systemHeadline)
                        .frame(width: userDevice.width342, alignment: .leading)
                        .foregroundStyle(.red)
                        .padding(.top, 12)
                        .padding(.leading, 24)
                    
                    Component.DefaultButton(text: "Masuk") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        viewModel.login(email: "angela@gmail.com", password: "angelaadmin")
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 24)
                    
                    Component.bottomSignText(text: "Tidak memiliki akun?", blueText: "Daftar") {
                        router.path.append(Page.Register)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 76 - userDevice.bottomSafeArea)
                }
//                .toolbar{
//                    ToolbarItem(placement: .topBarLeading) {
//                        Component.NavigationTitle(text: "Masuk", fontSize: .system(size: 34, weight: .bold))
//                    }
//                }
                
                if viewModel.status == .loading {
                    LoadingView()
                        .background(Color.black.opacity(0.4))
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationTitle("\(NSLocalizedString("Masuk", comment: ""))")
        }
        .onChange(of: viewModel.status, { _, newValue in
            if newValue == .success {
                router.path.append(Page.TabBar)
            }
        })
    }
}



#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
        .environmentObject(Router())
        .environmentObject(UserDevice())
        .environment(\.locale, .init(identifier: "id"))
}
