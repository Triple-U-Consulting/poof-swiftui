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
        VStack(spacing: 20) {
            if status == .loading {
                ProgressView()
                Text("\(self.message ?? "Loading")")
            }
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

