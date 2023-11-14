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
                    Spacer()
                    Component.DefaultText(text: "IOT1234567")
                }
                .padding(.horizontal, 36)
                .padding(.top, 12)
                
                Component.NextButton(text: "Pemicu Asma", borderColor: .white.opacity(0), shadowColor: .gray3) {
                    //logic
                }
                .padding(.top, 16)
                
                Component.NextButton(text: "Bahasa", borderColor: .white.opacity(0), shadowColor: .gray3) {
                    //logic
                }
                .padding(.top, 16)
                
                Spacer()
                
                Component.DefaultButton(text: "Keluar") {
                    //logic
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 155 - userDevice.bottomSafeArea)
            }
            .frame(width: userDevice.usableWidth)
            .background(.gray7)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Profil")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
//            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    ProfileTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
