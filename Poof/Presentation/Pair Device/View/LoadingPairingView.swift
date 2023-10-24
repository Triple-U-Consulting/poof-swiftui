//
//  LoadingPairingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct LoadingPairingView: View {
    
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                LottieViewComponent(name: "pairing-loading", loopMode: .loop)
                    .frame(width:358, height:169.53)
                Spacer()
            }
            .frame(height:512)
            
            VStack {
                Text("Pairing")
                    .font(.systemTitle1)
                
                Text("Please wait for a moment, we are \npairing it now")
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
                pairProgress = .successPairing
            }
        }
    }
}

//#Preview {
//    LoadingPairingView()
//}
