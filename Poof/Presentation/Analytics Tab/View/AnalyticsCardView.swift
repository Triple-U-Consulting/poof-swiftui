//
//  SummaryCardView.swift
//  Poof
//
//  Created by Angelica Patricia on 08/11/23.
//

import SwiftUI

struct AnalyticsCardView: View {
    var frequency: String
    var highestUsage: Int
    var lowestUsage: Int
    var totalDaytimeUsage: Int
    var totalNightUsage: Int
    var dayWithoutUsage: Int
    var body: some View {
        VStack (spacing: 20) {
            VStack {
                Text("Your inhaler usage this \(frequency)")
                    .font(.headline)
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Highest \(frequency)ly usage")
                        Spacer()
                        Text("\(highestUsage)")
                    }
                    
                    HStack {
                        Text("Lowest \(frequency)ly usage")
                        Spacer()
                        Text("\(lowestUsage)")
                    }
                }
                .padding([.leading,.trailing])
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .frame(maxWidth: 350)
            
            
            VStack {
                if totalDaytimeUsage > totalNightUsage {
                    Text("Your daytime usage is higher")
                        .font(.headline)
                } else if totalDaytimeUsage < totalNightUsage {
                    Text("Your night usage is higher")
                        .font(.headline)
                } else {
                    Text("Your daytime and night usage are the same")
                        .font(.headline)
                }
                    
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Total Daytime Usage")
                        Spacer()
                        Text("\(totalDaytimeUsage)")
                    }
                    
                    HStack {
                        Text("Total Night Usage")
                        Spacer()
                        Text("\(totalNightUsage)")
                    }
                }
                .padding([.leading,.trailing])
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .frame(maxWidth: 350)
            
            
            VStack {
                Text("You are not using Inhaler for \(dayWithoutUsage) \(frequency)s")
                    .font(.headline)
                
                Divider()
                
                VStack {
                    HStack {
                        Text("\(frequency) without Usage")
                        Spacer()
                        Text("\(dayWithoutUsage)")
                    }
                }
                .padding([.leading,.trailing])
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .frame(maxWidth: 350)
            
        }
        
        
    }
}

#Preview {
    AnalyticsCardView(frequency: "week", highestUsage: 2, lowestUsage: 3, totalDaytimeUsage: 5, totalNightUsage: 4, dayWithoutUsage: 0)
}
