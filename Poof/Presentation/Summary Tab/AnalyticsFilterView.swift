//
//  AnalyticsFilterView.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import SwiftUI

struct AnalyticsFilterView: View {
    @StateObject var viewModel = AnalyticsViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack {
                Picker("Frequency", selection: $viewModel.selectedFrequency) {
                    ForEach(Frequency.allCases) { frequency in
                        Text(frequency.rawValue).tag(frequency)
                    }
                }
                .onChange(of: viewModel.selectedFrequency) { newFrequency in
                    viewModel.fetchAnalytics()
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                HStack {
                    VStack(alignment:.leading) {
                        Text("Average")
                            .foregroundStyle(.primary1)
                        Text("\(viewModel.averagePuffs) Puff")
                            .font(.systemTitle1)
                        HStack {
                            Text("\(dateFormatter.string(from: viewModel.startDate ?? Date())) - \(dateFormatter.string(from: viewModel.endDate ?? Date()))")
                                .foregroundStyle(.primary1)
                            Spacer()
                            HStack(spacing: 15) {
                                Button(action: viewModel.goBackward) {
                                    Image(systemName: "chevron.left")
                                }
                                Button(action: viewModel.goForward) {
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .foregroundColor(.black)
                        }
                        
                    }
                    Spacer()
                }
                .padding()
                
                
                ChartView(analytics: $viewModel.analytics, frequency: viewModel.selectedFrequency.rawValue)
                    .frame(height: 300)
                    .padding()
                
                Component.DefaultButton(text: "Generate", buttonLevel: .secondary) {
                }
                .padding([.top,.bottom])
                
                AnalyticsCardView(frequency: viewModel.selectedFrequency.rawValue, highestUsage: viewModel.highestUsage, lowestUsage: viewModel.lowestUsage, totalDaytimeUsage: viewModel.totalDaytimeUsage, totalNightUsage: viewModel.totalNightUsage, dayWithoutUsage: viewModel.dayWithoutUsage)
            }
            .padding()
            .onAppear {
                viewModel.fetchAnalytics()
            }
            
        }
    }
}

#Preview {
    AnalyticsFilterView()
}

extension AnalyticsFilterView {
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
