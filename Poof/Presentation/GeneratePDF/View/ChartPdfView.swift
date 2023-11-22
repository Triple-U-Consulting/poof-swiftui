//
//  ChartPdfView.swift
//  Poof
//
//  Created by Geraldy Kumara on 20/11/23.
//

import SwiftUI
import Charts

struct ChartPdfView: View {
    
    @EnvironmentObject var vm: PdfViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                Chart {
                    ForEach(vm.pdfChartModel) {
                        LineMark(
                            x: .value("Week", $0.week),
                            y: .value("puff", $0.totalPuff ?? 0)
                        )
                        .foregroundStyle(Color.Main.blueTextSecondary)
                        .interpolationMethod(.monotone)
                        .lineStyle(.init(lineWidth: 1.75))
                        .symbol() {
                            Circle()
                                .fill(Color.Secondary.pdfSecondary)
                                .frame(width: 10)
                        }
                        .symbolSize(30)
                    }
                }
                .padding()
               // .chartLegend(position: .bottom, alignment: .center)
//                .chartForegroundStyleScale([
//                    "Usage Increase": Color.Main.blueTextSecondary, "Usage Decrease": Color.Secondary.pdfSecondary
//                ])
                .chartXAxis {
                    AxisMarks(position: .bottom) { value in
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [2]))
                            .foregroundStyle(Color.Main.blueTextSecondary)
                        AxisValueLabel(){
                            if let week = value.as(String.self) {
                                Text("\(week)")
                                    .font(.system(size: 10))
                            }
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading, values: stride(from: 0, to: 22, by: 2).map{ $0 }) {
                        AxisGridLine(centered: true)
                            .foregroundStyle(Color.Main.blueTextSecondary)
                        AxisValueLabel()
                    }
                }
                .chartYAxisLabel(position: .leading) {
                    VStack {
                        Text("Inhaler Dose")
                            .foregroundColor(Color.Main.blueTextSecondary)
                            .frame(minWidth: 66, minHeight: 50)
                        Divider()
                    }
                    .rotationEffect(.degrees(180))
                }
                .chartPlotStyle { plotArea in
                  plotArea
//                        .background(.blue.opacity(0.2))
//                        .border(Color.red, width: 2)
                }
                .frame(height: 300)
            }
        }
    }
}

#if DEBUG
struct ChartPdfView_Preview: PreviewProvider {
    static var previews: some View {
        ChartPdfView()
            .environmentObject(PdfViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
#endif
