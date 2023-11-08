//
//  DeepSleep.swift
//  Poof
//
//  Created by Angelica Patricia on 05/11/23.
//

import SwiftUI

struct ChartView: View {
    @Binding var analytics: [Analytics]
    var frequency: String
    var barSpacing: CGFloat {
            switch frequency {
            case "week":
                return 20
            case "month":
                return 35
            case "year":
                return 0
            default:
                return 20
            }
        }
    let chartHeight: CGFloat = 300
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .bottom, spacing: barSpacing) {
                ForEach(Array(zip(analytics.indices, analytics)), id: \.1.id) { (index, analytic) in
                    BarView(label: analytic.label,
                            daytimeUsage: analytic.daytimeUsage,
                            nightUsage: analytic.nightUsage,
                            frequency: frequency,
                            availableHeight: 200, index: index)
                }
            }
        }
        .frame(height: chartHeight)
    }
}
