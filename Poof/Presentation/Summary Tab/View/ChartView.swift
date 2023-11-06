//
//  DeepSleep.swift
//  Poof
//
//  Created by Angelica Patricia on 05/11/23.
//

import SwiftUI

struct BarView: View {
    var week: String
    var daytimePuffCounts: Double
    var nightPuffCounts: Double
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Path { path in
                    path.move(to: CGPoint(x: 1, y: 0))
                    path.addLine(to: CGPoint(x: 1, y: 500))
                }
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [.clear, Color.gray]), startPoint: .top, endPoint: .bottom),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [5, 5])
                )
                .frame(width: 3, height: 500)

                
                VStack (spacing: 3) {
                    
                    ZStack(alignment:.top){
                        Rectangle()
                            .frame(width: 50, height: (nightPuffCounts) * 50)
                            .foregroundColor(.primary1)
                        
                        Image(systemName: "moon.stars.fill")
                            .font(.systemTitle2)
                            .foregroundColor(.black.opacity(0.2))
                            .padding(.top)
                    }
                    
                    ZStack(alignment:.bottom) {
                        Rectangle()
                            .frame(width: 50, height: (daytimePuffCounts) * 50)
                            .foregroundColor(.secondary2)
                        
                        Image(systemName: "sun.max.fill")
                            .font(.systemTitle2)
                            .foregroundColor(.black.opacity(0.2))
                            .padding(.bottom)
                    }
                }
                .cornerRadius(25)

            }
            Text("Week \(week)")
                .foregroundStyle(.gray1)
        }
    }
}

//#Preview {
//    BarView(week: "1", daytimePuffCounts: 3.0, nightPuffCounts: 2.0)
//}

struct ChartView: View {
    let usageData = [
        UsageData(week: "1", daytimePuffCounts: 2, nightPuffCounts: 4),
        UsageData(week: "2", daytimePuffCounts: 3, nightPuffCounts: 5),
        UsageData(week: "3", daytimePuffCounts: 2.5, nightPuffCounts: 4.5),
        UsageData(week: "4", daytimePuffCounts: 3.5, nightPuffCounts: 5.5)
    ]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 25) {
            ForEach(usageData, id: \.week) { data in
                BarView(week: data.week, daytimePuffCounts: data.daytimePuffCounts, nightPuffCounts: data.nightPuffCounts)
            }
        }
    }
}

struct UsageData {
    var week: String
    var daytimePuffCounts: Double
    var nightPuffCounts: Double
}


#Preview {
    ChartView()
}
