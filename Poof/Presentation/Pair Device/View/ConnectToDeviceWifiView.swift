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
                Text("Connect to Wifi")
                    .font(.systemTitle1)
                
                Text("Connect your phone to inhaler's Wi-Fi \nand ensure it has sufficient battery.")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Component.DefaultButton(text: "Start Pairing", buttonLevel: .primary) {
                    pairProgress = .loadingPairing
                }
                .padding(.top, 40)
                
                Spacer()
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
