//
//  FailedPairingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct FailedPairingView: View {
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                VStack (spacing:0) {
                    Spacer()
                    LottieViewComponent(name: "pairing-failed", loopMode: .loop)
                        .frame(width:358, height:172.69)
                    Spacer()
                }
                
                VStack (spacing:0) {
                    Component.DefaultText(text: "Penyambungan Perangkat Gagal")
                        .font(.systemSubheader)
                    
                    Component.DefaultText(text: "Koneksi dengan perangkat Airo anda terputus. Silahkan coba hubungkan kembali.")
                        .lineLimit(3...3)
                        .padding(.top, 12)
                        .frame(width: 295)
                    
                    Component.DefaultButton(text: "Coba Lagi", buttonLevel: .primary) {
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
    FailedPairingView(pairProgress: .constant(PairDevicePage.failedPairing))
}
