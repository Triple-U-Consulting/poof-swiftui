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
        NavigationView {
            VStack (spacing:0){
                VStack (spacing:0) {
                    Spacer()
                    LottieViewComponent(name: "pairing-success", loopMode: .loop)
                        .frame(width:358, height:197.55)
                    Spacer()
                }
                
                VStack (spacing:0) {
                    Component.DefaultText(text: "Tersambung")
                        .font(.systemSubheader)
                    
                    Component.DefaultText(text: "Inhaler anda sudah tersambung dengan ponsel anda.")
                        .lineLimit(3...3)
                        .padding(.top, 12)
                        .frame(width: 295)
                    
                    Spacer()
                        .frame(height: 48)
                    .padding(.top, 88)
                }
                .frame(height: 195)
                .padding(.bottom, 44)
                
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Sambungkan Inhaler Anda")
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    router.path.append(Page.WifiConfig)
                }
            }
        }
    }
}

#Preview {
    SuccessPairingView(pairProgress: .constant(.successPairing))
        .environmentObject(Router())
}
