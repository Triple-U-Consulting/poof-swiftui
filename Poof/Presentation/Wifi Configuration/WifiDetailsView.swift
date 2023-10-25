//
//  WifiDetailsView.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import SwiftUI

struct WiFiDetailsView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var viewModel = WiFiDetailsViewModel()
    @State private var ssid: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false

    
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
                
                if viewModel.status == .success {
                    if viewModel.message == "WiFi Failed to Connect" {
                        Text("Tidak dapat terhubung ke Wi-Fi. Pastikan kembali SSID dan Kata Sandi anda")
                            .foregroundColor(.red)
                            .font(.systemBodyText)
                    }
                }
                
                Component.DefaultButton(text: "Post WiFi Details", buttonLevel: .primary) {
                    viewModel.postWiFiDetails(ssid: ssid, password: password)
                }
                
                Spacer()
                
            }
            .padding()
            
            if viewModel.isPopUpDisplayed {
                    WiFiDetailsPopUpView(status: $viewModel.status, message: $viewModel.message, dismissAction: {
                        viewModel.isPopUpDisplayed = false
                    })
                    .background(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Connection Lost"),
                message: Text("We can’t detect your inhaler. Please reconnect."),
                dismissButton: .default(Text("Oke"), action: {
                    viewModel.showAlert = false
                })
            )
        }


    }
}

#Preview {
    WiFiDetailsView()
        .environmentObject(Router())
}
