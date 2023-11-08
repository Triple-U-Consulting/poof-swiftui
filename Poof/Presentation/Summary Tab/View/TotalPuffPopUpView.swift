//
//  TotalPuffPopUpView.swift
//  Poof
//
//  Created by Angelica Patricia on 06/11/23.
//

import SwiftUI

struct TotalPuffPopUpView: View {
    var totalPuffs: Int
    var startDate: Date
    var endDate: Date
    var frequency: String
    var body: some View {
        VStack(spacing:0) {
            VStack(alignment:.leading) {
                Text("Total")
                    .font(.systemFootnote)
                    .foregroundColor(.primary1)
                Text("\(totalPuffs) Puff")
                    .font(.systemTitle2)
                if frequency=="week"{
                    Text("\(dateFormatter.string(from: startDate))")
                        .font(.systemFootnote)
                        .foregroundColor(.primary1)
                } else {
                    Text("\(dateFormatter.string(from: startDate ))-\(dateFormatter.string(from: endDate))")
                        .font(.systemFootnote)
                        .foregroundColor(.primary1)
                }
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

extension TotalPuffPopUpView {
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
