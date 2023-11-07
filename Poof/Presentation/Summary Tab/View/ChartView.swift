//
//  DeepSleep.swift
//  Poof
//
//  Created by Angelica Patricia on 05/11/23.
//

import SwiftUI

struct BarView: View {
    var week: String
    var daytimePuffCounts: Int
    var nightPuffCounts: Int
    @Binding var selectedWeek: String?
    var totalPuffs: Int {
        Int(daytimePuffCounts + nightPuffCounts)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Path { path in
                    path.move(to: CGPoint(x: 1, y: 0))
                    path.addLine(to: CGPoint(x: 1, y: 300))
                }
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [.clear, Color.gray3]), startPoint: .top, endPoint: .bottom),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [5, 5])
                )
                .frame(width: 3, height: 300)
                
                
                VStack (spacing: 3) {
                    
                    ZStack(alignment:.top){
                        Rectangle()
                            .frame(width: 30, height: CGFloat((nightPuffCounts)) * 20)
                            .foregroundColor(.primary1)
                        
                        Image(systemName: "moon.stars.fill")
                            .font(.systemFootnote)
                            .foregroundColor(.black.opacity(0.2))
                            .padding(.top,10)
                    }
                    
                    ZStack(alignment:.bottom) {
                        Rectangle()
                            .frame(width: 30, height: CGFloat((daytimePuffCounts)) * 20)
                            .foregroundColor(.secondary2)
                        
                        Image(systemName: "sun.max.fill")
                            .font(.systemFootnote)
                            .foregroundColor(.black.opacity(0.2))
                            .padding(.bottom,10)
                    }
                }
                .cornerRadius(20)
                
            }
            Text("W\(week)")
                .foregroundStyle(.gray1)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedWeek = self.selectedWeek == self.week ? nil : self.week
        }
    }
}

struct ChartView: View {
    let usageData = [
        UsageData(week: "1", daytimePuffCounts: 2, nightPuffCounts: 4),
        UsageData(week: "2", daytimePuffCounts: 3, nightPuffCounts: 5),
        UsageData(week: "3", daytimePuffCounts: 2, nightPuffCounts: 4),
        UsageData(week: "4", daytimePuffCounts: 3, nightPuffCounts: 5)
    ]
    @State private var selectedWeek: String?
    let barSpacing: CGFloat = 50
    let barWidth: CGFloat = 30
    @StateObject var vm = AnalyticsViewModel()
    var body: some View {
        VStack {
            Component.DefaultButton(text: "Fetch") {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let start_date = dateFormatter.date(from: "2023-11-01"),
                   let end_date = dateFormatter.date(from: "2023-11-07") {
                    vm.getAnalytics(start_date: start_date, end_date: end_date, frequency: "day")
                }
            }
            ZStack(alignment: .bottom) {
                if let week = selectedWeek,
                    let index = usageData.firstIndex(where: { $0.week == week }) {
                    let xOffset = CGFloat(index) * (barWidth + barSpacing)
                    
                    TotalPuffPopUpView(
                        totalPuffs: Int(usageData[index].daytimePuffCounts + usageData[index].nightPuffCounts),
                        dateRange: "6-13 Sep 2023"
                    )
                    .offset(x: xOffset - (UIScreen.main.bounds.width / 2)-3+80, y: -100)
                }
                
                HStack(alignment: .bottom, spacing: barSpacing) {
                    ForEach(Array(usageData.enumerated()), id: \.element.week) { index, data in
                        BarView(week: data.week, daytimePuffCounts: data.daytimePuffCounts, nightPuffCounts: data.nightPuffCounts, selectedWeek: $selectedWeek)
                            .onTapGesture {
                                self.selectedWeek = self.selectedWeek == data.week ? nil : data.week
                            }
                    }
                }
                .animation(.default, value: selectedWeek)
            }
        }

        
    }
}

struct UsageData {
    var week: String
    var daytimePuffCounts: Int
    var nightPuffCounts: Int
}


#Preview {
    ChartView()
        .environmentObject(AnalyticsViewModel())
}
