//
//  PairDeviceView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct PairDeviceView: View {
    
    @EnvironmentObject var router: Router
    
//    private var pairProgress = PairProgress.startPairing
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                LottieViewComponent(name: "pairing-loading", loopMode: .loop)
                    .frame(width:255, height:220)
                Spacer()
                Text("Pair Your Inhaler")
                    .font(.systemTitle)
                Text("Connecting your inhaler helps us to \nimprove our analysis.")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Component.DefaultButton(text: "Start Pairing") {
                    //logic
                }
                .padding(.top, 40)
                .padding(.bottom, 50)

            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.NavigationBackButton(text: "")
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

//enum PairProgress {
//    case startPairing
//    case connectToWiFi
//    case failedPairing
//    case loadingPairing
//    case successPairing
//}

