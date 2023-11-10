//
//  IrritantView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 10/11/23.
//

import SwiftUI

struct IrritantView: View {
    
    @EnvironmentObject var router: Router
    @Binding var pairProgress : PairDevicePage
    
    var body: some View {
        VStack {
            Text("irritant")
            
            Component.DefaultButton(text: "Done", buttonLevel: .primary, buttonState: .active) {
                pairProgress = .connectToDeviceWifi
                router.path.append(Page.TabBar)
            }
        }
    }
}

#Preview {
    IrritantView(pairProgress: .constant(PairDevicePage.irritant))
        .environmentObject(Router())
}
