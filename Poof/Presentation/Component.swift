//
//  Component.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import Foundation
import SwiftUI


struct Component {
    
    struct ProfileButton: View {
        
        var text: String
        
        var body: some View {
            Button {
                //logic
            } label : {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .renderingMode(.original) // Use original rendering mode
                    .frame(width: 54, height: 54)
                    .foregroundColor(.primary) // Set a foreground color
            }
//            .frame(width: 54, height: 54, alignment: .center)
            //.padding(.all, 20)
//            .background(Image(systemName: "person.crop.circle")
//                .resizable()
//                .frame(width: 54, height: 54)
//            )
        }
    }
    
    struct NavigationTitle: View {
        
        var text: String
        var body: some View {
            Text(text)
                .font(.title2)
        }
    }
    
    struct CircleButton: View {
        
        var text: String
        var diameter: CGFloat
        
        @State private var rotationAngle: Double = 0

        let gradientColors: [Color] = [Color.red, Color.blue]

        var body: some View {
            Button {
                //action
            } label : {
                Text(text)
                    .font(.title2)
                    .foregroundStyle(.black)

            }
            .frame(width: diameter, height: diameter)
            .background(Color.white)
            .clipShape(Circle())
        }
    }
    
    struct RotatingCircle: View {
        @State var gradientAngle: Double = 0
        let colors: [Color] = [
            .white,
            .red
        ]
        
        var body: some View {
            ZStack {
                Circle()
                .fill(AngularGradient(gradient: Gradient(colors: colors), center: .center, angle: .degrees(gradientAngle)))
                .brightness(0.1)
                .saturation(0.9)
                .blur(radius: 0)
            }
            .frame(width: 240, height: 240)
            .onAppear {
                withAnimation(Animation.linear(duration: 12).repeatForever(autoreverses: false)) {
                    self.gradientAngle = 360
                }
            }
        }
    }

    
}
