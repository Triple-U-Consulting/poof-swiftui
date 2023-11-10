//
//  RotatingCircleView.swift
//  Poof
//
//  Created by Angelica Patricia on 09/11/23.
//

import SwiftUI

struct RotatingCircleView: View {
    @State var gradientAngle: Double = 0
    let colors: [Color] = [.white, .red, .white]
    @Binding var syncStatus: SyncStatus
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: syncStatus == SyncStatus.syncing ? 0.25 : 1)
                        .stroke(LinearGradient(gradient: Gradient(colors: syncStatus == SyncStatus.syncing ? colors : syncStatus == SyncStatus.synced ? [.primary2] : [.red]), startPoint: .topTrailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(gradientAngle))
                        .frame(width: geometry.size.width-20, height:geometry.size.height-20)
                        .padding(.all, 10)
                }
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                    self.gradientAngle = 360
                }
            }
        }
        
    }
}

#Preview {
    RotatingCircleView( syncStatus: .constant(.syncing))
}
