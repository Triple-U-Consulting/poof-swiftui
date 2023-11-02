//
//  SummaryTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct SummaryTabView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("Summary")
            
            Component.DefaultButton(text: "Pairing") {
                router.path.append(Page.PairDevice)
            }
            .padding(.top, 68)
        }
        
    }
}

#Preview {
    SummaryTabView()
}
