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
        VStack (spacing:0){
            VStack (spacing:0){
                Spacer()
                
                LottieViewComponent(name: "pairing-start", loopMode: .loop)
                    .frame(width:255, height:220)
                Spacer()
            }
            .frame(height:435)
            
            Spacer()
            
            VStack (spacing:0) {
                Text("Pair Your Inhaler")
                    .font(.systemTitle1)
                
                Text("Connecting your inhaler helps us to \nimprove our analysis.")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Component.DefaultButton(text: "Next", buttonLevel: .primary) {
                    pairProgress = .connectToDeviceWifi
                }
                .padding(.top, 40)
                
                Spacer()
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
