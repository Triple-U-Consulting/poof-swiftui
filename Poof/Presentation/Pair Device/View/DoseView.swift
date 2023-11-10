//
//  DoseView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 10/11/23.
//

import SwiftUI

struct DoseView: View {
    
    @Binding var pairProgress : PairDevicePage
    @State private var remainingDose: String = ""
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            
            TextField(text: $remainingDose) {
                Text(verbatim: "Enter your remaining inhaler dose")
            }
            .autocapitalization(.none)
            .autocorrectionDisabled(true)
            .padding(.leading, 30)
            .textFieldStyle(.automatic)
            .padding(.vertical, 12)
            .padding(.leading, -10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.primary2, lineWidth: 2)
            )
            
            Component.DefaultButton(text: "Next", buttonLevel: .primary, buttonState: .active) {
//                pairProgress = .irritant
                router.path.append(Page.TabBar)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        
    }
}

#Preview {
    DoseView(pairProgress: .constant(PairDevicePage.dose))
        .environmentObject(Router())
}
