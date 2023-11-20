//
//  PrivacyPolicyView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 17/11/23.
//

import SwiftUI

struct PrivacyPolicyView: View {
    
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
                        
                        Welcome to Airopuff. This Privacy Policy outlines how we collect, use, and safeguard your personal information.
                        
                        **1. Information We Collect**
                        **a. Personal Information:**
                        When you register for an account or use certain features, we may collect personal information, including but not limited to your name, email address, and contact details.
                        **b. Health Information:**
                        The App may collect health-related information to provide personalized services. This may include medical history, symptoms, and other health-related data provided by you.
                        
                        **2. How We Use Your Information**
                        **a. We use your personal information to:**
                        Provide and improve the App's services.
                        Personalize your experience.
                        Communicate with you about your account and updates.
                        **b. Health information is used to:**
                        Provide accurate and relevant health-related content.
                        Enhance personalized health recommendations.
                        
                        **3. Data Security**
                        We take reasonable measures to protect your personal and health information from unauthorized access, disclosure, alteration, and destruction. However, no method of transmission over the internet or electronic storage is entirely secure.
                        
                        **4. Sharing of Information**
                        We do not sell, trade, or otherwise transfer your personal information to outside parties. However, we may share anonymized and aggregated data for research or analytical purposes.
                        
                        **5. Your Choices**
                        a. You can review and update your personal information in your account settings.
                        b. You may choose not to provide certain health information, but this may limit the functionality of certain features.
                        
                        **6. Changes to this Privacy Policy**
                        We reserve the right to modify this Privacy Policy at any time. Changes will be effective immediately upon posting on the App.
                        
                        **7. Contact Information**
                        For questions about this Privacy Policy, please contact us.
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
                            
                            Component.DefaultText(text: "I have read the Privacy Policy")
                            Spacer()
                        }
                        .padding(.top, 28)
                        
                        Component.DefaultButton(text: "I Agree") {
                            if isUserAgree {
                                router.path.append(Page.TermsAndCondition)
                            } else {
                                //kalo user blom agree
                            }
                        }
                        .padding(.top, 40)
                    }
                }
            }
            .padding(.horizontal, 16)
            .navigationTitle("\(NSLocalizedString("Privacy Policy", comment: ""))")
        }
    }
}

#Preview {
    PrivacyPolicyView()        
        .environmentObject(Router())
}


