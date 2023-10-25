//
//  SuccessPairingVIew.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct SuccessPairingView: View {
    
    @Binding var pairProgress : PairDevicePage
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                LottieViewComponent(name: "pairing-success", loopMode: .loop)
                    .frame(width:358, height:197.55)
                Spacer()
            }
            .frame(height:512)
            
            VStack {
                Text("Tersambung")
                    .font(.systemTitle1)
                
                Text("Inhaler anda sudah tersambung dengan perangkat anda.")
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
                router.path.append(Page.WifiConfig)
            }
        }
    }
}

//#Preview {
//    SuccessPairingView()
//}
