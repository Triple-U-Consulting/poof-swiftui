//
//  Component.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import Foundation
import SwiftUI

enum DefaultButtonLevel {
    case primary
    case secondary
}

enum DefaultButtonState {
    case active
    case inactive
}

enum DefaultDesign: CGFloat {
    case buttonPadding = 24
    case deviceWidth = 390
}

struct Component {
    
    // MARK: - BASIC DESIGN SYSTEM COMPONENT
    
    
    // DEFAULT TEXT WITH SPACING AND LINE HEIGHT
    // Usage Example: Component.DefaultText(text: "Text Label")
    struct DefaultText: View {
        
        var text: String
        
        var body: some View {
            Text(text)
                .multilineTextAlignment(.center)
                .lineSpacing(-2)
                .tracking(0.4)
        }
    }
    
    // DEFAULT BUTTON FOR THE APPS
    // Usage Example: Component.DefaultButton(text: "Text Label", buttonLevel: .primary, buttonState: .active) {logic}
    // Optional parameter: buttonLevel, buttonState
    struct DefaultButton: View {
        
        @EnvironmentObject var userDevice: UserDevice
        var text: String
        var buttonLevel: DefaultButtonLevel = .primary
        var buttonState: DefaultButtonState = .active
        var action: () -> Void
        
        var body: some View {
            VStack {
                Button(action: action) {
                    if (buttonLevel == .primary) {
                        Primary(Text(text))
                    } else if (buttonLevel == .secondary)  {
                        Secondary(Text(text))
                    }
                }
            }
            .padding(.horizontal, 24*userDevice.usableWidth/DefaultDesign.deviceWidth.rawValue)
        }
        
        private func Primary(_ text: Text) -> some View {
            text
                .font(.systemButtonText)
                .foregroundStyle(self.buttonState==DefaultButtonState.active ? .white : Color.Neutrals.gray2)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(self.buttonState==DefaultButtonState.active ? Color.Main.primary1 : Color.Main.primary3)
                .cornerRadius(10)
                .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 10)
        }
        
        private func Secondary(_ text: Text) -> some View {
            text
                .font(.systemButtonText)
                .foregroundStyle(self.buttonState==DefaultButtonState.active ? Color.Main.primary1 : Color.Neutrals.gray2)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(.white)
                .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(self.buttonState==DefaultButtonState.active ? Color.Main.primary1 : Color.Neutrals.gray2, lineWidth: 2)
                )
        }
    }
    
    
    // NEXT BUTTON FOR PROFILE
    // Usage Example: Component.NextButton(text: "Text Label") {logic}
    struct NextButton: View {
        var text: String
        var action: () -> Void
        var body: some View {
            Button(action: action) {
                HStack {
                    Text(text)
                        .padding(.leading, 33.5)
                    Spacer()
                    Text(Image(systemName: "chevron.right"))
                        .padding(.trailing, 33.5)
                }
                    .font(.systemButtonText)
                    .foregroundStyle(.black)
                    .frame(width: 342, height: 47)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( Color.Main.primary1, lineWidth: 2)
                    )
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
            .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 10)
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


// PREVIEW BUAT TEST COMPONENT
#Preview {
    VStack {
        Component.DefaultButton(text: "Text Label") {
            //logic
        }
        
        Component.DefaultButton(text: "Text Label", buttonLevel: .secondary) {
            //logic
        }
        
        Component.NextButton(text: "Text Label") {
            //logic
        }
    }
}
