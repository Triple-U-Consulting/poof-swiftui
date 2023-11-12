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
    @State private var navigationTitleText: String = "Sambungkan Inhaler Anda"
    
    var body: some View {
        VStack {
            switch pairProgress {
            case .startPairing:
                StartPairingView(pairProgress: $pairProgress)
            case .connectToDeviceWifi:
                ConnectToDeviceWifiView(pairProgress: $pairProgress)
            case .loadingPairing:
                LoadingPairingView(pairProgress: $pairProgress)
                    .environmentObject(PairingViewModel())
            case .failedPairing:
                FailedPairingView(pairProgress: $pairProgress)
            case .successPairing:
                SuccessPairingView(pairProgress: $pairProgress)
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
    case connectToDeviceWifi
    case loadingPairing
    case failedPairing
    case successPairing
}
