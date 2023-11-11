//
//  LoadingView.swift
//  Poof
//
//  Created by Angela Christabel on 11/11/23.
//

import SwiftUI

struct LoadingView: View {
    var dismissAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
            Text("Memuat")
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
