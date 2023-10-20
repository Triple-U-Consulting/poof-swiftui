//
//  WifiDetailsPopUpView.swift
//  Poof
//
//  Created by Angelica Patricia on 20/10/23.
//

import SwiftUI

struct WiFiDetailsPopUpView: View {
    @Binding var status: WiFiDetailsPopUpStatus
    @Binding var message: String?
    var dismissAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            if status == .loading {
                ProgressView()
                Text("Mengirimkan Data...")
            } else if status == .success {
                if message == "WiFi Failed to Connect." {
                    Text(message ?? "")
                    Button("Input Ulang WiFi yang Benar", action: dismissAction)
                } else {
                    Text(message ?? "")
                    Button("Selesai", action: dismissAction)
                }
            } else if status == .failure {
                Text(message ?? "")
                Button("Check Kembali Koneksi Anda dengan Puffer Device", action: dismissAction)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


//#Preview {
//    WiFiDetailsPopUpView()
//}
