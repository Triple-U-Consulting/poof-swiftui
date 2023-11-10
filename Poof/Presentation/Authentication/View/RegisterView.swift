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
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var email: String = ""
    //@State private var dob: Date?
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    // @State private var currentPage: SignPage = .register
    //var currentPage: Page
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            NavigationView {
                ZStack {
                    Color(.white).ignoresSafeArea()
                    VStack (spacing:0) {
                        Component.titleSignPage(text: "Email")
                        
                        TextField(text: $email) {
                            Text(verbatim: "john.doe@gmail.com")
                        }
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .autocapitalization(.none)
                        .padding(.top, 8)
                        
                        Component.CustomDivider(width: 342)
                        
//                        Component.titleSignPage(text: "Tanggal Lahir")
//                        
//                        Component.DatePickerTextField(placeholder: NSLocalizedString("HH.BB.TTTT", comment: ""), date: $dob)
//                            .frame(height: 34)
//                        //.background(Color.black)
//                            .padding([.leading, .trailing], 30)
//                            .padding(.top, 8)
//                        
//                        Component.CustomDivider(width: 342)
                        
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
                            
//                            if viewModel.message == "Email already registered"{
//                                Component.textErrorMessageSignPage(string: "Email sudah terdaftar")
//                            } else {
//                                Component.textErrorMessageSignPage(string: viewModel.message)
//                            }
                            
                            Component.DefaultButton(text: "Sign Up") {
                                viewModel.register(email: email, password: password, confirmPassword: confirmPassword)
                                //                                    router.path.removeLast()
                            }
                            .padding(.top, 5)
                            .padding(.horizontal, 24)
                            Component.bottomSignText(text: "Sudah memiliki akun?", blueText: "Masuk") {
                                router.path.removeLast()
                            }
                            .padding(.top, 25)
                            .padding(.bottom, 76 - userDevice.bottomSafeArea)
                        }
                        .position(x: 190, y: 395)
                    }
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading) {
                            Component.NavigationTitle(text: "Daftar")
                                .padding(.top, 16)
                        }
                    }
                }
                
            }
            .padding(8)
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
