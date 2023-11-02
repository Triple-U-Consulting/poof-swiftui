//
//  LoadingPairingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct LoadingPairingView: View {
    
    @Binding var pairProgress : PairDevicePage
    @EnvironmentObject var vm: ViewModel

    
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
                Text("Menyambungkan")
                    .font(.systemTitle1)
                
                Text("Mohon tunggu sebentar, kami sedang menyambungkan perangkat anda.")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Spacer()
            }
            .frame(height: 195)
            .padding(.bottom, 83)
            .onReceive(vm.$status, perform: { newStatus in
//                pairProgress = .failedPairing
                            switch newStatus {
                            case .failure(_):
                                print("failure")
                                pairProgress = .failedPairing
                            case .success:
                                pairProgress = .successPairing
                            default:
                                break
                            }
                        })
            
        }
        .onAppear(perform: {
                    vm.findInhaler()
                })
    }
}

//#Preview {
//    LoadingPairingView()
//}
