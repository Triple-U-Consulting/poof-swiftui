//
//  SummaryCardView.swift
//  Poof
//
//  Created by Angelica Patricia on 08/11/23.
//

import SwiftUI

struct AnalyticsCardView: View {

    @StateObject var viewModel = AnalyticsViewModel()
    @Binding var summary: [Summary]
    
    var body: some View {
        VStack (spacing: 20) {
            VStack {
                Text("Berdasarkan data Anda menggunakan inhaler lebih banyak bulan ini dibanding bulan sebelumnya.")
                    .font(.headline)
                
                Divider()
                
                VStack (spacing: 15) {
                    VStack (spacing: 8) {
                        HStack {
                            Text("Pemakaian Tertinggi")
                            Spacer()
                            Text("26")
                        }
                        HStack {
                            Text("November")
                                .foregroundStyle(.white)
                                .frame(width: 100)
                                .background(RoundedRectangle(cornerRadius: 2).fill(.primary1))
                            
                            Spacer()
                        }
                    }
                    
                    VStack (spacing:8){
                        HStack {
                            Text("Pemakaian Terendah")
                            Spacer()
                            Text("0")
                        }
                        HStack {
                            Text("Juni")
                                .foregroundStyle(.white)
                                .frame(width: 100)
                                .background(RoundedRectangle(cornerRadius: 2).fill(.primary1))
                            
                            Spacer()
                        }
                    }
                    

                }
                .padding([.leading,.trailing])
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .frame(maxWidth: 350)
            
            
            VStack {
                    Text("Selama 6 bulan terakhir, pemakaian inhaler malam anda tertinggi pada bulan November.")
                        .font(.headline)
                
                Divider()
                
                VStack (spacing:15) {
                    VStack (spacing:8) {
                        HStack {
                            Text("Total Daytime Usage")
                            Spacer()
                            Text("18 / 26")
                        }
                        HStack {
                            Text(" ")
                                .foregroundStyle(.white)
                                .frame(width: 100)
                                .background(RoundedRectangle(cornerRadius: 2).fill(.secondary1))
                            
                            Spacer()
                        }
                    }
                   
                    
                    VStack (spacing:8) {
                        HStack {
                            Text("Total Night Usage")
                            Spacer()
                            Text("8 / 26")
                        }
                        HStack {
                            Text(" ")
                                .foregroundStyle(.white)
                                .frame(width: 100)
                                .background(RoundedRectangle(cornerRadius: 2).fill(.primary1))
                            
                            Spacer()
                        }
                    }
                   
                }
                .padding([.leading,.trailing])
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .frame(maxWidth: 350)
            
            
            VStack {
                Text("Selama 6 bulan terakhir, anda tidak menggunakan inhaler 163 hari.")
                    .font(.headline)
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Hari tanpa Inhaler")
                        Spacer()
                        Text("163")
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

//#Preview {
//    AnalyticsCardView(
//        frequency: "week", highestUsage: 2, lowestUsage: 3, totalDaytimeUsage: 5, totalNightUsage: 4, dayWithoutUsage: 0
//    )
//}
