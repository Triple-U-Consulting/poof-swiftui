//
//  ConnectToWifiView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct ConnectToDeviceWifiView: View {
    
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                VStack (spacing:0) {
                    Spacer()
                    Image("pairing-connectToDeviceWifi")
                        .resizable()
                        .frame(width:376, height:211)
                    Spacer()
                }
                
                VStack (spacing:0) {
                    Component.DefaultText(text: "Sambungkan ke Wi-Fi")
                        .font(.systemSubheader)
                    
                    Component.DefaultText(text: "Buka setelan ponsel dan hubungkan ke Wi-Fi inhaler. Kata sandi Wi-Fi dapat anda lihat pada kemasan.")
                        .lineLimit(3...3)
                        .padding(.top, 12)
                        .frame(width: 295)
                    
                    Component.DefaultButton(text: "Sudah Terkoneksi", buttonLevel: .primary) {
                        pairProgress = .loadingPairing
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
                    Component.NavigationTitle(text: "Sambungkan ke Wi-Fi")
                }
            }
        }
    }
}

#Preview {
    ConnectToDeviceWifiView(pairProgress: .constant(PairDevicePage.connectToDeviceWifi))
        .environmentObject(Router())
}
