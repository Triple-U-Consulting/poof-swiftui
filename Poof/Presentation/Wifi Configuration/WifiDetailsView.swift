//
//  WifiDetailsView.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import SwiftUI

struct WiFiDetailsView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var pairingStateManager: StateManager
    @StateObject var viewModel = WiFiDetailsViewModel()
    @State private var ssid: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing:0){
                    Component.titleSignPage(text: "SSID")
                    
                    TextField("Nama Wi-Fi", text: $ssid)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .padding(.top, 8)
                    
                    Component.CustomDivider(width: 342)
                    
                    Component.titleSignPage(text: "Kata Sandi")
                    
                    TextField("Kata Sandi Wi-Fi", text: $password)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding(.leading, 30)
                        .textFieldStyle(.automatic)
                        .padding(.top, 8)
                    
                    Component.CustomDivider(width: 342)
                    
                    if viewModel.message == "WiFi Failed to Connect." {
                        Text("Tidak dapat terhubung ke Wi-Fi. Pastikan kembali SSID dan Kata Sandi Anda.")
                            .lineLimit(2...2)
                            .foregroundColor(.red)
                            .font(.systemBodyText)
                    }
                    
                    Component.DefaultButton(text: "Bergabung", buttonLevel: .primary) {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        if !viewModel.inhalerConnectedWifi {
                            viewModel.postWiFiDetails(ssid: ssid, password: password)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                
                if viewModel.isPopUpDisplayed {
                    WiFiDetailsPopUpView(status: $viewModel.status, message: $viewModel.message, dismissAction: {
                        viewModel.isPopUpDisplayed = false
                    })
                    .background(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Pilih Wi-Fi untuk Inhaler")
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
            .onChange(of: viewModel.updatedUserInhaler, initial: false, {
                router.path.append(Page.InputDose)
            })
        }
    }
}

#Preview {
    WiFiDetailsView()
        .environmentObject(Router())
}
