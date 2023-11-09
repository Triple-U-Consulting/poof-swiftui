//
//  DeepSleep.swift
//  Poof
//
//  Created by Angelica Patricia on 05/11/23.
//

import SwiftUI

struct ChartView: View {
    @Binding var analytics: [Analytics]
    @Binding var selectedIndex: Int?
    var frequency: String
    var barSpacing: CGFloat {
        switch frequency {
        case "week":
            return 15
        case "month":
            return 25
        case "quarter":
            return 60
        case "halfyear":
            return 15
        case "year":
            return 0
        default:
            return 20
        }
    }
    let chartHeight: CGFloat = 300
    @Binding var isLoading: Bool
    
    var body: some View {
        if isLoading {
            ProgressView()
                .frame(height: chartHeight)
        } else {
            ZStack(alignment: .bottom) {
                HStack(alignment: .bottom, spacing: barSpacing) {
                    ForEach(Array(zip(analytics.indices, analytics)), id: \.1.id) { (index, analytic) in
                        BarView(label: analytic.label,
                                daytimeUsage: analytic.daytimeUsage,
                                nightUsage: analytic.nightUsage,
                                frequency: frequency,
                                availableHeight: 200,
                                totalUsage: analytic.daytimeUsage+analytic.nightUsage,
                                startDate: analytic.start_date,
                                endDate: analytic.end_date,
                                index: index , selectedIndex: $selectedIndex)
                    }
                }
            }
            .frame(height: chartHeight)
            
        }
    }
}
