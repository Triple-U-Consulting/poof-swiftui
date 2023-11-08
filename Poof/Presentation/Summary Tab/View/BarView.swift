//
//  BarView.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import SwiftUI

struct BarView: View {
    var label: String
    var daytimeUsage: Int
    var nightUsage: Int
    var frequency: String
    var availableHeight: CGFloat
    private var heightMultiplier: CGFloat {
        switch frequency {
        case "week":
            return 20
        case "month":
            return 5
        case "quarter":
            return 8
        case "halfyear":
            return 8
        case "year":
            return 8
        default:
            return 20
        }
    }
    private var totalUsage: Int {
        daytimeUsage + nightUsage
    }
    @State private var isSelected: Bool = false
    var body: some View {
        VStack {
            Spacer()
            if isSelected {
                Text("\(totalUsage)")
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(10)
                    .offset(y: 0)
            }
            ZStack(alignment:.bottom){
                Path { path in
                    path.move(to: CGPoint(x: 1, y: 0))
                    path.addLine(to: CGPoint(x: 1, y: 300))
                }
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [.clear, Color.gray3]), startPoint: .top, endPoint: .bottom),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [5, 5])
                )
                .frame(width: 3, height: 300)
                
                VStack(spacing:3) {
                    Rectangle()
                        .frame(width: 30, height: min(availableHeight, CGFloat(nightUsage) * heightMultiplier))
                        .foregroundColor(.primary1)
                    
                    Rectangle()
                        .frame(width: 30, height: min(availableHeight, CGFloat(daytimeUsage) * heightMultiplier))
                        .foregroundColor(.secondary2)
                }
                .cornerRadius(25)
                .onTapGesture {
                    isSelected.toggle()
                }
            }
            Text(label)
        }
    }
}
