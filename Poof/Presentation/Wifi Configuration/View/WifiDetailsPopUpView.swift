//
//  WifiDetailsPopUpView.swift
//  Poof
//
//  Created by Angelica Patricia on 20/10/23.
//

import SwiftUI

struct WiFiDetailsPopUpView: View {
    @Binding var status: WiFiDetailsStatus
    @Binding var message: String?
    var dismissAction: () -> Void

    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                if status == .loading {
                     ProgressView()
                    Text("\(self.message ?? "Loading")")
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: geo.size.width/2, maxHeight: .infinity, alignment: .center)
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(8)
    }
}

