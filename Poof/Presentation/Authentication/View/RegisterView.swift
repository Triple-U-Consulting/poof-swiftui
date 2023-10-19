//
//  RegisterView.swift
//  Poof
//
//  Created by Geraldy Kumara on 13/10/23.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var viewModel = UserViewModel()
    @State private var email: String = ""
    @State private var dob: Date?
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
//var currentPage: Page
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            NavigationStack(path: $router.path) {
                ZStack {
                    Color(.white).ignoresSafeArea()
                    VStack{
                        Component.titleSignPage(text: "Email")
                        
                        TextField(text: $email) {
                            Text(verbatim: "loremipsum@gmail.com")
                        }
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        
                        Component.dividerSignPage()
                        
                        Component.titleSignPage(text: "Date of Birth")
                            
                        Component.DatePickerTextField(placeholder: "DD-MM-YYYY", date: $dob)
                            .frame(height: 34)
                            //.background(Color.black)
                            .padding([.leading, .trailing], 30)
                        
                        Component.dividerSignPage()
                        
                        Component.titleSignPage(text: "Password")
                        
                        SecureField(text: $password) {
                            Text(verbatim: "Create Password")
                        }
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        
                        Component.dividerSignPage()
                        
                        Component.titleSignPage(text: "Confirm Password")
                        
                        SecureField(text: $confirmPassword) {
                            Text(verbatim: "Confirm Password")
                        }
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        
                        Component.dividerSignPage()
                        
                        Spacer()
                        
                        Component.DefaultButton(text: "Sign Up") {
                            viewModel.registerUser(email: email, password: password, dob: dob!, confirmPassword: confirmPassword)
                        }
                        .position(x: UIScreen.main.bounds.width / 2.05, y: UIScreen.main.bounds.height - 650)
                        
                        Component.bottomSignText(text: "Already have an account?", blueText: "Sign In") {
                            
                        }
                        .position(x: UIScreen.main.bounds.width / 2.05, y: UIScreen.main.bounds.height - 730)
                        
                        if let message = viewModel.message{
                            Text(message)
                                .foregroundStyle(.green)
                        }
                        
                        if let error = viewModel.error{
                            Text(error)
                                .foregroundStyle(.red)
                        }
                        
                    }
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading) {
                            Component.NavigationTitle(text: "Sign Up")
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
        .environmentObject(Router())
}
