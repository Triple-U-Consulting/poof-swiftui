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
        VStack {
            VStack {
                Spacer()
                
                LottieViewComponent(name: "pairing-failed", loopMode: .loop)
                    .frame(width:358, height:172.69)
                Spacer()
            }
            .frame(height:512)
            
            VStack {
                Text("Failed to Pair")
                    .font(.systemTitle1)
                
                Text("Please make sure that you have your \ninhaler near you.")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Spacer()
            }
            .frame(height: 195)
            .padding(.bottom, 83)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                pairProgress = .connectToDeviceWifi
            }
        }
    }
}

//#Preview {
//    FailedPairingView()
//}
