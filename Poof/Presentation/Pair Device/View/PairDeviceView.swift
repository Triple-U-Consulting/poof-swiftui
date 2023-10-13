//
//  PairDeviceView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct PairDeviceView: View {
    
    @EnvironmentObject var router: Router
    
    @State private var pairProgress = PairDevicePage.startPairing
    
    var body: some View {
        NavigationView {
            VStack {
                switch pairProgress {
                case .startPairing:
                    StartPairingView(pairProgress: $pairProgress)
                case .connectToWifi:
                    ConnectToWifiView(pairProgress: $pairProgress)
                case .failedPairing:
                    VStack {}
                case .loadingPairing:
                    VStack {}
                case .successPairing:
                    VStack {}
                }
            }
            .toolbar {
                if pairProgress == PairDevicePage.startPairing {
                    ToolbarItem(placement: .topBarLeading) {
                        Component.NavigationBackButton(text: "")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Pair Your Device")
                        .font(.systemTitle)
                }
            }
        }
    }
}

#Preview {
    PairDeviceView()
        .environmentObject(Router())
}

enum PairDevicePage {
    case startPairing
    case connectToWifi
    case failedPairing
    case loadingPairing
    case successPairing
}


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
                Text("Pair Your Inhaler")
                    .font(.systemTitle)
                
                Text("Connecting your inhaler helps us to \nimprove our analysis.")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Component.DefaultButton(text: "Start Pairing", buttonLevel: .primary) {
                    pairProgress = .connectToWifi
                }
                .padding(.top, 40)
                
                Spacer()
            }
            .frame(height: 195)
            .padding(.bottom, 83)
            
        }
    }
}



struct ConnectToWifiView: View {
    
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                Image("pairing-connectToWifi")
                    .resizable()
                    .frame(width:376, height:211)
                Spacer()
            }
            .frame(height:512)
            
            VStack {
                Text("Connect to Wifi")
                    .font(.systemTitle)
                
                Text("Connect your phone to inhaler's Wi-Fi \nand ensure it has sufficient battery.")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Component.DefaultButton(text: "Start Pairing", buttonLevel: .primary) {
                    pairProgress = .connectToWifi
                }
                .padding(.top, 40)
                
                Spacer()
            }
            .frame(height: 195)
            .padding(.bottom, 83)
            
        }
    }
}
