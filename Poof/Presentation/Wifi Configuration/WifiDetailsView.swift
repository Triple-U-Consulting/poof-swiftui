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
            
            if let message = viewModel.message {
                Text(message)
                    .foregroundColor(.green)
            }
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}


#Preview {
    WiFiDetailsView()
}
