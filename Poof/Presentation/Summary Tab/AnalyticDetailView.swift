//
//  AnalyticDetailView.swift
//  Poof
//
//  Created by Angelica Patricia on 04/11/23.
//

import SwiftUI

struct AnalyticDetailView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Average")
                        .foregroundStyle(.primary1)
                    HStack {
                        Text("6")
                        Text("Puff")
                    }
                    .font(.systemTitle1)
                    .bold()
                    Text("28 Agustus - 28 September")
                        .foregroundStyle(.primary1)
                    
                }
                
                Spacer()
            }
        
            Text("Chart")
                .frame(width: 350, height: 300)
                .background(.primary1)
                .padding()
            
            VStack (alignment: .leading) {
                Text("Monthly Usage")
                    .font(.systemSubheader)
                    .foregroundStyle(.primary1)
                VStack {
                    HStack {
                        Text("Highest Daily Usage")
                        Spacer()
                        Text("3")
                    }
                    HStack {
                        Text("Lowest Daily Usage")
                        Spacer()
                        Text("1")
                    }
                    HStack {
                        Text("Daytime Usage")
                        Spacer()
                        Text("4")
                    }
                    HStack {
                        Text("Night Usage")
                        Spacer()
                        Text("8")
                    }
                    HStack {
                        Text("Day Without Usage")
                        Spacer()
                        Text("1")
                    }
                }
                .padding([.leading,.trailing])
            }
            .padding()
            .background(.gray3.opacity(0.4))
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    AnalyticDetailView()
}
