//
//  LoadingView.swift
//  Poof
//
//  Created by Angela Christabel on 11/11/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
            Text("\(NSLocalizedString("Memuat", comment: ""))")
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(8)
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
