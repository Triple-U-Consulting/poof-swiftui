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
    @State private var dob: Date?
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
                        
                        Component.dividerSignPage()
                            .padding(.top, 8)
                        
                        Component.titleSignPage(text: "Tanggal Lahir")
                            
                        Component.DatePickerTextField(placeholder: NSLocalizedString("HH.BB.TTTT", comment: ""), date: $dob)
                            .frame(height: 34)
                            //.background(Color.black)
                            .padding([.leading, .trailing], 30)
                            .padding(.top, 8)
                        
                        Component.dividerSignPage()
                            .padding(.top, 8)
                        
                        Component.titleSignPage(text: "Kata Sandi")
                        
                        SecureField(text: $password) {
                            Text(verbatim: NSLocalizedString("Buat Kata Sandi", comment: ""))
                        }
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .padding(.top, 8)
                        
                        Component.dividerSignPage()
                            .padding(.top, 8)
                        
                        Component.titleSignPage(text: "Konfirmasi Kata Sandi")
                        
                        SecureField(text: $confirmPassword) {
                            Text(verbatim: NSLocalizedString("Ketik Ulang Kata Sandi Anda", comment: ""))
                        }
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .padding(.top, 8)
                        
                        Component.dividerSignPage()
                            .padding(.top, 8)
                        
                        Spacer()
                        
                        
                        Component.DefaultButton(text: "Sign Up") {
                            viewModel.register(email: email, password: password, dob: dob, confirmPassword: confirmPassword)
                            router.path.removeLast()
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 24)
                        
                        Component.bottomSignText(text: "Sudah memiliki akun?", blueText: "Masuk") {
                            router.path.removeLast()
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 76 - userDevice.bottomSafeArea)
                        
//                        if let message = viewModel.message{
//                            Text(message)
//                                .foregroundStyle(.green)
//                        }
//                        
//                        if let error = viewModel.error{
//                            Text(error)
//                                .foregroundStyle(.red)
//                        }
                        
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
}
