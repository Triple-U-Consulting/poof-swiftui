//
//  ConnectToHomeWifiView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 16/10/23.
//

import SwiftUI

struct ConnectToHomeWifiView: View {
    
    @EnvironmentObject var router: Router
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                Button("Open Wi-Fi Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                Spacer()
            }
            .frame(height:512)
            
            VStack {
                Text("Choose a Wi-Fi")
                    .font(.systemTitle1)
                
                Text("This will be the network source\nfor your inhaler to sync data")
                    .frame(width: 291, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
                Component.DefaultButton(text: "Done", buttonLevel: .primary, buttonState: .active) {
                    pairProgress = .dose
                    router.path.append(Page.TabBar)
                }
                
                Spacer()
            }
            .frame(height: 195)
            .padding(.bottom, 83)
            
        }
    }
}

//#Preview {
//    ConnectToHomeWifiView()
//}
