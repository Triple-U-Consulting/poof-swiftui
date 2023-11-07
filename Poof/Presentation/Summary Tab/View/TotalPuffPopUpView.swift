//
//  TotalPuffPopUpView.swift
//  Poof
//
//  Created by Angelica Patricia on 06/11/23.
//

import SwiftUI

struct TotalPuffPopUpView: View {
    var totalPuffs: Int
    var dateRange: String
    var body: some View {
        VStack(spacing:0) {
            VStack(alignment:.leading) {
                Text("Total")
                    .font(.systemFootnote)
                    .foregroundColor(.primary1)
                Text("\(totalPuffs) Puff")
                    .font(.systemTitle2)
                Text(dateRange)
                    .font(.systemFootnote)
                    .foregroundColor(.primary1)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.gray3)
            .cornerRadius(10)

            Path { path in
                path.move(to: CGPoint(x: 1, y: 0))
                path.addLine(to: CGPoint(x: 1, y: 200))
            }
            .stroke(Color.gray3,
                style: StrokeStyle(lineWidth: 4)
            )
            .frame(width: 4, height: 200)
        }
            }
}

#Preview {
    TotalPuffPopUpView(totalPuffs: 5, dateRange: "6-13 Sep 2023")
}
