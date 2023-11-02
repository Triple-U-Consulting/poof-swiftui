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
        VStack {
            VStack {
                Spacer()
                
                LottieViewComponent(name: "pairing-start", loopMode: .loop)
                    .frame(width:255, height:220)
                Spacer()
            }
            .frame(height:512)
            
            
            VStack {
                Text("Sambungkan Inhaler Anda")
                    .font(.systemTitle1)
                
                Text("Menyambungkan inhaler membantu kami untuk membuat analisis yang lebih baik.")
                    .frame(width: 291, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Spacer()
                Component.DefaultButton(text: "Berikutnya", buttonLevel: .primary) {
                    pairProgress = .connectToDeviceWifi
                }
                .padding(.bottom, 40)
            }
            .frame(height: 195)
            .padding(.bottom, 53)
            
        }
    }
}

//#Preview {
//    
//    @State var pairProgress = PairDevicePage.startPairing
//    
//    StartPairingView(pairProgress: $pairProgress)
//        .environmentObject(Router())
//}
