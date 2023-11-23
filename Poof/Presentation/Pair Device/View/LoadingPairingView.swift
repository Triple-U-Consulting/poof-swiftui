//
//  LoadingPairingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct LoadingPairingView: View {
    
    @Binding var pairProgress : PairDevicePage
    @EnvironmentObject var vm: PairingViewModel

    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                VStack (spacing:0) {
                    Spacer()
                    LottieViewComponent(name: "pairing-loading", loopMode: .loop)
                        .frame(width:358, height:169.53)
                    Spacer()
                }
                
                VStack (spacing:0) {
                    Component.DefaultText(text: "Menyambungkan...")
                        .font(.systemSubheader)
                    
                    Component.DefaultText(text: "Mohon tunggu sebentar, kami sedang menyambungkan perangkat Airo anda.")
                        .lineLimit(3...3)
                        .padding(.top, 12)
                        .frame(width: 295)
                    
                    Spacer()
                        .frame(height: 48)
                    .padding(.top, 88)
                }
                .frame(height: 195)
                .padding(.bottom, 44)
                .onReceive(vm.$status, perform: { newStatus in
                    switch newStatus {
                    case .failure(_):
                        print("failure")
                        pairProgress = .successPairing
                    case .success:
                        pairProgress = .successPairing
                    default:
                        pairProgress = .successPairing
                        break
                    }
                })
                
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Sambungkan Perangkat Airo Anda")
                }
            }
            .onAppear(perform: {
                vm.findInhaler()
            })
        }
    }
}

#Preview {
    LoadingPairingView(pairProgress: .constant(PairDevicePage.loadingPairing))
        .environmentObject(PairingViewModel())
}
