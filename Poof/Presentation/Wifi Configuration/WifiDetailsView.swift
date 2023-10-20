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
            VStack(spacing: 30) {
                VStack {
                    Text("Choose a Wi-Fi")
                        .font(.systemTitle2)
                    Text("Wi-Fi akan menjadi sumber koneksi internet untuk inhaler melakukan singkronisasi.")
                        .font(.systemBodyText)
                        .multilineTextAlignment(.center)
                }
                
                VStack (spacing: 20) {
                    
                    VStack(alignment: .leading, spacing:0) {
                        HStack (spacing: 0){
                                Text("SSID")
                                Text("*")
                                    .foregroundColor(Color.red)
                            }
                        TextField("Wi-Fi Name", text: $ssid)
                            .padding()
                            .background(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(Color.gray), alignment: .bottom
                                    )
                    }
                   
                    
                    VStack (alignment: .leading, spacing:0) {
                        HStack (spacing: 0){
                                Text("Password")
                                Text("*")
                                    .foregroundColor(Color.red)
                            }
                        SecureField("Wi-Fi Password", text: $password)
                            .padding()
                            .background(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(Color.gray), alignment: .bottom
                                    )
                    }
                    
                    
                }
                Button(action: {
                    viewModel.postWiFiDetails(ssid: ssid, password: password)
                }) {
                    Text("Post WiFi Details")
                        .font(.systemButtonText)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.primary1)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                }
                
                Spacer()

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
