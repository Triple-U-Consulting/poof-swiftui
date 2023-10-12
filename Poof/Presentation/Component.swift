//
//  Component.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import Foundation
import SwiftUI


struct Component {
    
    // MARK: - BASIC DESIGN SYSTEM COMPONENT
    
    // DEFAULT BUTTON FOR THE APPS
    // Usage Example: Component.DefaultButton(text: "text") {logic}
    struct DefaultButton: View {
        var text: String
        var action: () -> Void
        var body: some View {
            Button(action: action) {
                Text(text)
                    .font(.systemButtonText)
                    .foregroundStyle(.white)
                    .frame(width: 342, height: 47)
                    .background(Color.Main.primary)
                    .cornerRadius(10)
                    .shadow(color: Color("Shadow"), radius: 12, x: 0, y: 10)
            }
        }
    }
    

    // TODO: BLOM KELAR
    struct CircleButton: View {
        var text: String
        var diameter: CGFloat
        @Binding var didSync : Bool
        var body: some View {
            Button {
                didSync = true
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
    
    // TODO: BLOM KELAR
    struct RotatingCircle: View {
        @State var gradientAngle: Double = 0
        let colors: [Color] = [.white, .red]
        @Binding var didSync: Bool
        var body: some View {
            ZStack {
                Circle()
                    .fill(AngularGradient(gradient: Gradient(colors: didSync ? colors : [.red]), center: .center, angle: .degrees(gradientAngle)))
                    .brightness(0.1)
                    .saturation(0.9)
                    .blur(radius: 0)
                    .frame(width: 267, height: 267)
                Circle()
                    .fill(.white)
                    .frame(width: 247, height:247)
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                    self.gradientAngle = 360
                }
            }
        }
    }
    
    // MARK: - NAVIGATION SYSTEM COMPONENT
    
    // CUSTOM NAVIGATION TITLE FOR NAVIGATION BAR
    // Usage Example: Component.NavigationTitle(text: "abc")
    struct NavigationTitle: View {
        var text: String
        var body: some View {
            Text(text)
                .font(.systemTitle2)
        }
    }
    
    // CUSTOM BACK BUTTON FOR NAVIGATION BAR
    // Usage Example: Component.NavigationBackButton(text: "abc")
    struct NavigationBackButton: View {
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
                    Text("\(self.text)")
                        .foregroundColor(.black)
                        .font(.systemBodyText)
                }
            }
        }
    }

    // USER PROFILE BUTTON AT NAVIGATION BAR
    // Usage Example: Component.ProfileButton() {logic}
    struct ProfileButton: View {
        var action: () -> Void
        var body: some View {
            Button(action: action) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .renderingMode(.original) // Use original rendering mode
                    .frame(width: 54, height: 54)
                    .foregroundColor(.primary) // Set a foreground color
            }
        }
    }
    
    
    
    
    
}
