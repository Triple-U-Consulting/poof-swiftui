//
//  InstallPairingView.swift
//  Poof
//
//  Created by Angela Christabel on 22/11/23.
//

import SwiftUI

struct InstallPairingView: View {
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                VStack (spacing:0) {
                    Spacer()
                    LottieViewComponent(name: "pairing-install", loopMode: .loop)
                        .frame(width:255, height:220)
                    Spacer()
                }
                
                VStack (spacing:0) {
                    Component.DefaultText(text: "Pasangkan Airo ke Inhaler")
                        .font(.systemSubheader)
                    
                    Component.DefaultText(text: "Pasangkan Airo ke bagian atas inhaler ventolin anda.")
                        .lineLimit(3...3)
                        .padding(.top, 12)
                        .frame(width: 295)
                    
                    Component.DefaultButton(text: "Berikutnya", buttonLevel: .primary) {
                        pairProgress = .startPairing
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 88)
                }
                .frame(height: 195)
                .padding(.bottom, 44)
                
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Pasangkan Airo ke Inhaler")
                }
            }
        }
    }
}

#Preview {
    InstallPairingView(pairProgress: .constant(.installAiro))
}
