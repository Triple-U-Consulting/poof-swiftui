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
            return 35
        case "month":
            return 20
        case "quarter":
            return 10
        case "halfyear":
            return 10
        case "year":
            return 5
        default:
            return 20
        }
    }
    var totalUsage: Int
    var startDate: Date
    var endDate: Date
    var index: Int
    @Binding var selectedIndex: Int?
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
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
                    
                    if daytimeUsage == 0 {
                        Rectangle()
                            .frame(width: 30, height: min(availableHeight, CGFloat(nightUsage) * heightMultiplier))
                            .foregroundColor(.primary1)
                            .cornerRadius(25)
                            .onTapGesture {
                                if selectedIndex == index {
                                    selectedIndex = nil
                                } else {
                                    selectedIndex = index
                                }
                            }
                        
                    } else if nightUsage == 0 {
                        Rectangle()
                            .frame(width: 30, height: min(availableHeight, CGFloat(daytimeUsage) * heightMultiplier))
                            .foregroundColor(.secondary2)
                            .cornerRadius(25)
                        
                            .onTapGesture {
                                if selectedIndex == index {
                                    selectedIndex = nil
                                } else {
                                    selectedIndex = index
                                }
                            }
                    } else {
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
                            if selectedIndex == index {
                                selectedIndex = nil
                            } else {
                                selectedIndex = index
                            }
                        }
                        
                    }
                    
                }
                Text(label)
            }
            .overlay(
                selectedIndex == index ?
                TotalPuffPopUpView(totalPuffs: totalUsage, startDate: startDate, endDate: endDate, frequency: frequency)                            .frame(width: 200)
                    .offset(y: -25)
                : nil
            )
            
            
            VStack {
                Spacer()
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
                    
                    if daytimeUsage == 0 && nightUsage != 0 {
                        ZStack(alignment:.top) {
                            Rectangle()
                                .frame(width: 30, height: min(availableHeight, CGFloat(nightUsage) * heightMultiplier))
                                .foregroundColor(.primary1)
                                .cornerRadius(25)
                                .onTapGesture {
                                    if selectedIndex == index {
                                        selectedIndex = nil
                                    } else {
                                        selectedIndex = index
                                    }
                                }
                            Image(systemName: "moon.stars.fill")
                                .foregroundStyle(.black.opacity(0.25))
                                .padding(.top,10)
                        }
                    } else if nightUsage == 0 && daytimeUsage != 0 {
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .frame(width: 30, height: min(availableHeight, CGFloat(daytimeUsage) * heightMultiplier))
                                .foregroundColor(.secondary2)
                                .cornerRadius(25)
                            
                                .onTapGesture {
                                    if selectedIndex == index {
                                        selectedIndex = nil
                                    } else {
                                        selectedIndex = index
                                    }
                                }
                            
                            Image(systemName: "sun.max.fill")
                                .foregroundStyle(.black.opacity(0.25))
                                .padding(.bottom,10)
                        }
                        
                    } else if (daytimeUsage != 0) && (nightUsage != 0) {
                        VStack(spacing:3) {
                            ZStack (alignment: .top) {
                                Rectangle()
                                    .frame(width: 30, height: min(availableHeight, CGFloat(nightUsage) * heightMultiplier))
                                    .foregroundColor(.primary1)
                                
                                Image(systemName: "moon.stars.fill")
                                    .foregroundStyle(.black.opacity(0.25))
                                    .padding(.top,10)
                            }
                            
                            ZStack (alignment: .bottom) {
                                Rectangle()
                                    .frame(width: 30, height: min(availableHeight, CGFloat(daytimeUsage) * heightMultiplier))
                                    .foregroundColor(.secondary2)
                                
                                Image(systemName: "sun.max.fill")
                                    .foregroundStyle(.black.opacity(0.25))
                                    .padding(.bottom,10)
                            }
                            
                        }
                        .cornerRadius(25)
                        .onTapGesture {
                            if selectedIndex == index {
                                selectedIndex = nil
                            } else {
                                selectedIndex = index
                            }
                        }
                        
                    }
                    
                }
                Text(label)
            }
        }
    }
}

