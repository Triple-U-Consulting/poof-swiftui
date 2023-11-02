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
                Text("Pilih Wi-Fi untuk Inhaler")
                    .font(.systemTitle2)
                
                VStack (spacing: 20) {
                    
                    VStack(alignment: .leading, spacing:0) {
                        HStack (spacing: 0){
                            Text("SSID")
                            Text("*")
                                .foregroundColor(Color.red)
                        }
                        TextField("Nama Wi-Fi", text: $ssid)
                            .padding()
                            .background(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.gray), alignment: .bottom
                            )
                    }
                    
                    
                    VStack (alignment: .leading, spacing:0) {
                        HStack (spacing: 0){
                            Text("Kata Sandi")
                            Text("*")
                                .foregroundColor(Color.red)
                        }
                        SecureField("Kata Sandi Wi-Fi", text: $password)
                            .padding()
                            .background(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.gray), alignment: .bottom
                            )
                    }
                    
                    
                }
                
                if viewModel.status == .success && viewModel.message == "WiFi Failed to Connect." {
                    Text("Tidak dapat terhubung ke Wi-Fi. Pastikan kembali SSID dan Kata Sandi anda")
                        .foregroundColor(.red)
                        .font(.systemBodyText)
                }
                
                Component.DefaultButton(text: "Bergabung", buttonLevel: .primary) {
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
            
            if viewModel.status == .success && viewModel.message != "WiFi Failed to Connect." {
                TabBarView()
                    .environmentObject(router)
                    .navigationBarHidden(true)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Koneksi Hilang"),
                message: Text("Koneksi dengan inhaler terputus. Silahkan menghubungkan kembali."),
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
