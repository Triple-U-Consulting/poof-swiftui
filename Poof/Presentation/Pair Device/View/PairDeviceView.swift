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
    @State private var navigationTitleText: String = "Pair Your Inhaler"
    
    var body: some View {
        NavigationView {
            VStack {
                switch pairProgress {
                case .startPairing:
                    StartPairingView(pairProgress: $pairProgress)
                case .connectToDeviceWifi:
                    ConnectToDeviceWifiView(pairProgress: $pairProgress)
                case .loadingPairing:
                    LoadingPairingView(pairProgress: $pairProgress)
                        .environmentObject(ViewModel())
                case .failedPairing:
                    FailedPairingView(pairProgress: $pairProgress)
                case .successPairing:
                    SuccessPairingView(pairProgress: $pairProgress)
                case .connectToHomeWifi:
                    ConnectToHomeWifiView(pairProgress: $pairProgress)
                case .dose:
                    DoseView(pairProgress: $pairProgress)
                case .irritant:
                    IrritantView(pairProgress: $pairProgress)
                }
            }
            .toolbar {
//                if pairProgress == PairDevicePage.startPairing {
//                    ToolbarItem(placement: .topBarLeading) {
//                    }
//                }
                ToolbarItem(placement: .principal) {
                    Text("\(navigationTitleText)")
                        .font(.systemTitle1)
                }
            }
            .onChange(of: pairProgress) { _, newValue in
                switch newValue {
                case .startPairing:
                    navigationTitleText = "Pair Your Inhaler"
                case .connectToDeviceWifi:
                    navigationTitleText = "Pair Your Inhaler"
                case .loadingPairing:
                    navigationTitleText = "Pair Your Inhaler"
                case .failedPairing:
                    navigationTitleText = "Pair Your Inhaler"
                case .successPairing:
                    navigationTitleText = "Pair Your Inhaler"
                case .connectToHomeWifi:
                    navigationTitleText = "Pair Your Inhaler"
                case .dose:
                    navigationTitleText = "Input Remaining Inhaler Doses"
                case .irritant:
                    navigationTitleText = "Irritants"
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
    case connectToDeviceWifi
    case loadingPairing
    case failedPairing
    case successPairing
    case connectToHomeWifi
    case dose
    case irritant
}
