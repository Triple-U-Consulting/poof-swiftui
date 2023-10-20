//
//  WifiDetailsView.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import SwiftUI

struct WiFiDetailsView: View {
    @StateObject var viewModel = WiFiDetailsViewModel()
    @State private var ssid: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                TextField("SSID", text: $ssid)
                    .padding()
                    .border(Color.gray)
                SecureField("Password", text: $password)
                    .padding()
                    .border(Color.gray)
                Button("Post WiFi Details") {
                    viewModel.postWiFiDetails(ssid: ssid, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()

            if viewModel.isPopUpDisplayed {
                WiFiDetailsPopUpView(status: $viewModel.popUpStatus, message: $viewModel.message, dismissAction: {
                    viewModel.isPopUpDisplayed = false
                })
                .background(Color.black.opacity(0.4))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    WiFiDetailsView()
}
