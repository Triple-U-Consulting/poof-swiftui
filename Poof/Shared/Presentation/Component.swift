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

struct Component {
    
    // MARK: - BASIC DESIGN SYSTEM COMPONENT
    
    
    // DEFAULT TEXT WITH SPACING AND LINE HEIGHT
    // Usage Example: Component.DefaultText(text: "Text Label")
    struct DefaultText: View {
        
        var text: String
        var textAlignment: TextAlignment = .center
        
        var body: some View {
            Text(NSLocalizedString(text, comment: ""))
                .multilineTextAlignment(textAlignment)
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
                        Primary(Text(NSLocalizedString(text, comment: "")))
                    } else if (buttonLevel == .secondary)  {
                        Secondary(Text(NSLocalizedString(text, comment: "")))
                    }
                }
            }
//            .padding(.horizontal, 24)
        }
        
        private func Primary(_ text: Text) -> some View {
            text
                .font(.systemButtonText)
                .foregroundStyle(self.buttonState==DefaultButtonState.active ? .white : Color.Neutrals.gray2)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(self.buttonState==DefaultButtonState.active ? Color.Main.primary1 : Color.Main.primary3)
                .cornerRadius(10)
                .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 4)
        }
        
        private func Secondary(_ text: Text) -> some View {
            text
                .font(.systemButtonText)
                .foregroundStyle(self.buttonState==DefaultButtonState.active ? Color.Main.primary1 : Color.Neutrals.gray2)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(.white)
                .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 4)
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
        var borderColor: Color = Color.primary1
        var action: () -> Void
        var body: some View {
            Button(action: action) {
                HStack {
                    Text(NSLocalizedString(text, comment: ""))
                        .padding(.leading, 20)
                    Spacer()
                    Text(Image(systemName: "chevron.right"))
                        .padding(.trailing, 20)
                        .foregroundColor(.primary1)
                }
                    .font(.systemButtonText)
                    .foregroundStyle(.black)
                    .frame(width: 342, height: 47)
                    .background(.white)
                    .cornerRadius(10)
//                    .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: 2)
                    )
            }
        }
    }
    
    
    // TODO: BLOM KELAR
    struct CircleView: View {
        var text: String
        @Binding var syncStatus: SyncStatus
        @Binding var todayIntake: CGFloat
        @Binding var remainingIntake: CGFloat
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: geometry.size.width-80, height: geometry.size.height-80)
                        .shadow(color: Color.Neutrals.gray3, radius: 12, x: 0, y: 10)
                        .padding(.all, 40)
                    if syncStatus == .unsynced {
                        Image(systemName:"exclamationmark.triangle.fill")
                            .resizable()
                            .padding(.all, 110)
                    } else if syncStatus == .syncing {
                        //empty
                    } else {
                        WaveView(todayIntake: $todayIntake, remainingIntake: $remainingIntake)
                    }
                }
            }
        }
    }
    
    // TODO: BLOM KELAR
    struct RotatingCircle: View {
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
    
    // MARK: - NAVIGATION SYSTEM COMPONENT
    
    // CUSTOM NAVIGATION TITLE FOR NAVIGATION BAR
    // Usage Example: Component.NavigationTitle(text: "abc")
    struct NavigationTitle: View {
        var text: String
        var fontSize: Font = .systemTitle2
        var body: some View {
            Text(NSLocalizedString(text, comment: ""))
                .font(fontSize)
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
                    Text(NSLocalizedString(self.text, comment: ""))
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
                Image("profileIcon")
                    .resizable()
                    .renderingMode(.original) // Use original rendering mode
                    .frame(width: 44, height: 44)
                    .foregroundColor(.primary) // Set a foreground color
            }
        }
    }
    
    struct TextButton: View {
        var text: String
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(text)
                    .foregroundStyle(Color.Main.blueTextSecondary)
            }
        }
    }
    
    struct CustomDivider: View {
        var width: CGFloat
        var body: some View {
            Divider()
                .frame(width: width, height: 1)
                .padding(.top, 8)
        }
    }
}



struct Wave: Shape {
    // how high our waves should be
    var strength: Double

    // how frequent our waves should be
    var frequency: Double
    
    var phase: Double
    
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        // calculate some important values up front
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height / 2

        // split our total width up based on the frequency
        let wavelength = width / frequency

        // start at the left center
        path.move(to: CGPoint(x: 0, y: midHeight))

        // now count across individual horizontal points one by one
        for x in stride(from: 0, through: width, by: 1) {
            // find our current position relative to the wavelength
            let relativeX = x / wavelength

            // calculate the sine of that position
//            let sine = sin(relativeX)
            let sine = sin(relativeX + phase)

            // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
            let y = strength * sine + midHeight

            // add a line to here
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return Path(path.cgPath)
    }
}

struct WaveView: View {
    @State private var dose: CGFloat = 200
    @Binding var todayIntake: CGFloat
    @Binding var remainingIntake: CGFloat //assuming out of 200
    @State private var phase = 0.0
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width:180, height: 180)
                    .foregroundStyle(.secondary3)
                    .offset(y:200-(remainingIntake*0.9))
            }
            .frame(width:180, height: 180)
            Wave(strength: 8, frequency: 6, phase: phase)
                .stroke(Color.secondary3, lineWidth: 16)
                .frame(width:200, height: 180)
                .offset(y: 110-(remainingIntake*0.9))
            Wave(strength: 8, frequency: 6, phase: phase)
                .stroke(Color.secondary2, lineWidth: todayIntake)
                .frame(width:200, height: 180)
                .offset(y: 110-(remainingIntake*0.9)-8+(todayIntake*0.45))
            
        }
        .frame(width:180, height: 180)
        .clipShape(Circle())
        .onAppear {
            withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                self.phase = .pi * 2
            }

        }
    }
}


struct ComponentView: View {
    @State private var phase = 0.0
    
    var body: some View {
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
            
            ZStack (alignment: .center) {
                Component.RotatingCircle(syncStatus: .constant(.unsynced))
                    .background(.cyan)
                Component.CircleView(text: "Sinkronisasi", syncStatus: .constant(SyncStatus.synced), todayIntake: .constant(5), remainingIntake: .constant(120))
            }
            .frame(width: 260, height: 260)
            .padding(.top, 16)
            
            Component.ProfileButton() {}
            
        }
    }
}

// PREVIEW BUAT TEST COMPONENT
#Preview {
    ComponentView()
}



