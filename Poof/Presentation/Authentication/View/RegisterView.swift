//
//  RegisterView.swift
//  Poof
//
//  Created by Geraldy Kumara on 13/10/23.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @ObservedObject private var viewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white).ignoresSafeArea()
                VStack (spacing:0) {
                    VStack {
                        Component.titleSignPage(text: "Email")
                        
                        TextField(text: $email) {
                            Text(verbatim: "loremipsum@gmail.com")
                        }
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .autocapitalization(.none)
                        .padding(.top, 8)
                        
                        Component.CustomDivider(width: 342)
                        
                        Component.titleSignPage(text: "Kata Sandi")
                        
                        SecureField(text: $password) {
                            Text(verbatim: NSLocalizedString("Buat Kata Sandi", comment: ""))
                        }
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .padding(.top, 8)
                        
                        Component.CustomDivider(width: 342)
                        
                        Component.titleSignPage(text: "Konfirmasi Kata Sandi")
                        
                        SecureField(text: $confirmPassword) {
                            Text(verbatim: NSLocalizedString("Ketik Ulang Kata Sandi Anda", comment: ""))
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
                    
                    VStack{
                        
                        switch viewModel.message {
                        case "Email already registered":
                            Component.textErrorMessageSignPage(string: "Email sudah terdaftar")
                        case "User registered":
                            Text("")
                        case self.viewModel.message:
                            Component.textErrorMessageSignPage(string: viewModel.message)
                        default:
                            Text("")
                        }
                    }
                    
                    //                            if viewModel.message == "Email already registered"{
                    //                                Component.textErrorMessageSignPage(string: "Email sudah terdaftar")
                    //                            } else {
                    //                                Component.textErrorMessageSignPage(string: viewModel.message)
                    //                            }
                    
                    Component.DefaultButton(text: "Daftar") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        viewModel.register(email: email, password: password, confirmPassword: confirmPassword)
                    }
                    .padding(.top, 5)
                    .padding(.horizontal, 24)
                    
                    Component.bottomSignText(text: "Sudah memiliki akun?", blueText: "Masuk") {
                        router.path.removeLast()
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 76 - userDevice.bottomSafeArea)
                    
                }
                
                if viewModel.status == .loading {
                    LoadingView()
                        .background(Color.black.opacity(0.4))
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationTitle("\(NSLocalizedString("Daftar", comment: ""))")
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
        .environmentObject(UserDevice())
        .environmentObject(Router())
        .environment(\.locale, .init(identifier: "id"))
}
