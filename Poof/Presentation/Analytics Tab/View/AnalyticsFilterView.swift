//
//  AnalyticsFilterView.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import SwiftUI

struct AnalyticsFilterView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @StateObject var viewModel = AnalyticsViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker("Frequency", selection: $viewModel.selectedFrequency) {
                        ForEach(Frequency.allCases) { frequency in
                            if frequency.rawValue=="week" {
                                Text("W").tag(frequency)
                            } else if frequency.rawValue=="month" {
                                Text("M").tag(frequency)
                            } else if frequency.rawValue=="quarter" {
                                Text("3M").tag(frequency)
                            } else if frequency.rawValue=="halfyear" {
                                Text("6M").tag(frequency)
                            }
                            
                        }
                    }
                    .onChange(of: viewModel.selectedFrequency) { newFrequency in
                        viewModel.fetchAnalytics()
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading,.trailing])
                    
                    HStack {
                        VStack(alignment:.leading) {
                            if viewModel.selectedIndex == nil {
                                HStack {
                                    Text("Average")
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
                                
                                Text("\(viewModel.averagePuffs) Puff")
                                    .font(.systemTitle1)
                                Text("\(dateFormatter.string(from: viewModel.startDate ?? Date())) - \(dateFormatter.string(from: viewModel.endDate ?? Date()))")
                                    .foregroundStyle(Color.Main.primary1)
                            }
                            
                            
                            
                        }
                        .frame(height:80)
                        Spacer()
                    }
                    .padding()
                    
                    ChartView(analytics: $viewModel.analytics, selectedIndex: $viewModel.selectedIndex, frequency: viewModel.selectedFrequency.rawValue, isLoading: $viewModel.isLoading)
                        .frame(height: 300)
                        .padding()
                        .gesture(DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    viewModel.goForward()
                                } else if value.translation.width > 0 {
                                    viewModel.goBackward()
                                }
                            })

                    AnalyticsCardView(summary: $viewModel.summary)
                    .padding()
                }
                .padding()
                .onAppear {
                    viewModel.fetchAnalytics()
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Analitik", fontSize: .systemTitle1)
                        .accessibilityAddTraits(.isHeader)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Generated!")
                    }label:{
                        Image("generate")
                            .padding(.trailing)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.Neutrals.gray8)
        }
        
    }
}

#Preview {
    AnalyticsFilterView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}

extension AnalyticsFilterView {
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
