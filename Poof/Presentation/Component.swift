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
    
    struct DefaultButton: View {
        
        var text: String
        
        var body: some View {
            Button {
                //logic
            } label : {
                Text(text)
                    .foregroundStyle(.black)
                    .foregroundColor(.black)
                    .frame(width: 342, height: 47)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
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
                .font(.systemTitle2)
        }
    }
    
    struct CircleButton: View {
        
        var text: String
        var diameter: CGFloat

        var body: some View {
            Button {
                //action
            } label : {
                Text(text)
                    .font(.systemButtonText)
                    .foregroundStyle(.black)
            }
            .frame(width: diameter, height: diameter)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: Color("Shadow"), radius: 12, x: 0, y: 10)
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
                    .frame(width: 267, height: 267)
                Circle()
                    .fill(.white)
                    .frame(width: 247, height:247)
            }
//            .frame(width: 257, height: 257)
            .onAppear {
                withAnimation(Animation.linear(duration: 12).repeatForever(autoreverses: false)) {
                    self.gradientAngle = 360
                }
            }
        }
    }
    
    
    struct NavigationBackButton: View {
        
//        var page: Page
        var text: String
        @EnvironmentObject var router: Router
        
        var body: some View {
            Button {
                router.path.removeLast()
            } label: {
                HStack {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .foregroundColor(.black)
//                        .frame(width: 18, height: 29)
                    Text("\(self.text)")
                        .foregroundColor(.black)
                        .font(.systemBodyText)
                }
            }
        }
    }

    
}
