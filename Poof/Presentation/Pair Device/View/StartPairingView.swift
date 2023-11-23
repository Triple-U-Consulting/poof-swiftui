//
//  StartPairingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct StartPairingView: View {
    
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                VStack (spacing:0) {
                    Spacer()
                    LottieViewComponent(name: "pairing-start", loopMode: .loop)
                        .frame(width:255, height:220)
                    Spacer()
                }
                
                VStack (spacing:0) {
                    Component.DefaultText(text: "Sambungkan Perangkat Airo Anda")
                        .font(.systemSubheader)
                    
                    Component.DefaultText(text: "Sambungkan perangkat Airo anda untuk pengalaman lebih baik.")
                        .lineLimit(3...3)
                        .padding(.top, 12)
                        .frame(width: 295)
                    
                    Component.DefaultButton(text: "Berikutnya", buttonLevel: .primary) {
                        pairProgress = .connectToDeviceWifi
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
                    Component.NavigationTitle(text: "Sambungkan Perangkat Airo Anda")
                }
            }
        }
    }
}

#Preview {
    StartPairingView(pairProgress: .constant(PairDevicePage.startPairing))
        .environmentObject(Router())
}
