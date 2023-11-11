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
        VStack {
            VStack {
                Spacer()
                
                Image("pairing-connectToDeviceWifi")
                    .resizable()
                    .frame(width:376, height:211)
                Spacer()
            }
            .frame(height:512)
            
            VStack {
                Text("Sambungkan ke Wi-Fi")
                    .font(.systemTitle1)
                
                Text("Buka setelan ponsel anda dan hubungkan ke Wi-Fi inhaler. Pastikan inhaler memiliki baterai yang cukup.")
                    .frame(width: 291, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                
                Spacer()
                Component.DefaultButton(text: "Berikutnya", buttonLevel: .primary) {
                    pairProgress = .loadingPairing
                }
                .padding(.bottom, 40)
            }
            .frame(height: 195)
            .padding(.bottom, 83)
            
        }
    }
}

//#Preview {
//    ConnectToWifiView(pairProgress: $pairProgress)
//        .environmentObject(Router())
//}
