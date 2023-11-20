//
//  ProfileTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 07/11/23.
//

import SwiftUI

struct ProfileTabView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                HStack {
                    Component.DefaultText(text: "ID Inhaler")
                        .padding(.leading, 24)
                    Spacer()
                    Component.DefaultText(text: "IOT1234567")
                        .padding(.trailing, 24)
                }
                .frame(width: 342)
                .padding(.vertical, 12)
                .foregroundStyle(.black)
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white.opacity(0), lineWidth: 2)
                )
                
                VStack {
                    Component.NextButton(text: "Pemicu Asma", borderColor: .primary1, shadowColor: .white.opacity(0)) {
                        //logic
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 12)
                    
                    Component.NextButton(text: "Bahasa", borderColor: .primary1, shadowColor: .white.opacity(0)) {
                        //logic
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                }
                .frame(width: 342)

                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white.opacity(0), lineWidth: 2)
                    )
                .padding(.top, 32)
                
                Spacer()
                
                Component.DefaultButton(text: "Keluar") {
                    //logic
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 155 - userDevice.bottomSafeArea)
                //                }
            }
            .frame(width: userDevice.usableWidth)
            .background(.gray7)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Profil", fontSize: .systemTitle1)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
