//
//  TermsAndConditionsView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 20/11/23.
//

import SwiftUI

struct TermsAndConditionsView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @State private var isUserAgree: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 0) {
                Component.DefaultText(text: "Last Updated November 17, 2023")
                Component.CustomDivider(width: .infinity)
                    .padding(.top, 20)
                ScrollView {
                    VStack (spacing:0) {
                        Text("""
                        
                        **1. Acceptance of Terms**
                        By using the App, you agree to comply with and be bound by these Terms. If you do not agree with any part of these Terms, please do not use the App.

                        **2. Medical Disclaimer**
                        The content provided by the App is for informational purposes only. It is not intended to be a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.

                        **3. User Eligibility**
                        You must be at least 17 years old to use the App. By using the App, you affirm that you are at least 17 years old or have obtained parental or guardian consent.

                        **4. User Accounts**
                        To access certain features of the App, you may be required to register for an account. You agree to provide accurate, current, and complete information during the registration process. You are responsible for maintaining the confidentiality of your account and password.

                        **5. Data Privacy**
                        Your use of the App is also governed by our Privacy Policy. Please review this policy to understand our practices regarding the collection and use of your information.

                        **6. User Conduct**
                        You agree not to engage in any of the following activities:
                        - Violating any applicable laws or regulations.
                        - Impersonating any person or entity.
                        - Uploading, transmitting, or distributing any viruses or other harmful code.

                        **7. Modifications to Terms**
                        We reserve the right to update or modify these Terms at any time without prior notice. Your continued use of the App after any such changes indicates your acceptance of the new Terms.

                        **8. Termination**
                        We may terminate or suspend your access to the App without prior notice for any reason.

                        **9. Contact Information**
                        For questions about these Terms, please contact us.
                        """)
                        
                        
                        HStack {
                            VStack {
                                Image(systemName: isUserAgree ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                            .onTapGesture {
                                isUserAgree.toggle()
                            }
                            .padding(.leading, 4)
                            
                            Component.DefaultText(text: "I have read the Terms and Condition")
                            Spacer()
                        }
                        .padding(.top, 28)
                        
                        Component.DefaultButton(text: "I Agree") {
                            if isUserAgree {
                                router.path.append(Page.Login)
                            } else {
                                //kalo user blom agree
                            }
                        }
                        .padding(.top, 40)
                    }
                }
            }
            .padding(.horizontal, 16)
            .navigationTitle("\(NSLocalizedString("Terms and Conditions", comment: ""))")
        }
    }
}

#Preview {
    TermsAndConditionsView()
}
