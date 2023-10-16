//
//  OnboardingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var router: Router
    @State private var selectedPage = 0
    
    private var title : [String] = [
        "AiroPuff",
        "Pair Your Smart Inhaler",
        "Sync Your Smart Inhaler",
        "Reminder Notification"
    ]
    private var details : [String] = [
        "AiroPuff is an application designed to assist parents in monitoring their child's asthma condition.",
        "Our inhaler will monitor your daily puffs and provide you with room temperature information.",
        "Remember to synchronize your smart inhaler daily to enable us to store your data.",
        "We will send you daily reminders to remind you take your medication and synchronize your inhaler."
    ]
    
    
    var body: some View {
        VStack {
//            GeometryReader { geometry in
//                Button {
//                    print(geometry.size.width)
//                    print(geometry.size.height)
//                } label : {
//                    Text("abc")
//                }
//            }
            
            //IMAGE
            TabView(selection: $selectedPage) {
                ForEach(0..<4) { index in
                    Image("onboardingArtwork-\(index+1)")
                        .resizable()
                        .frame(width: 390, height: 402)
                        .tag(index)
                }
            }
            .padding(.top, 102)
            .frame(height: 512)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            //DETAILS
            VStack {
                Text("\(title[selectedPage])")
                    .font(.systemTitle)
                
                Text("\(details[selectedPage])")
                    .frame(width: 342, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .frame(minHeight: 57)
                    .font(.systemBodyText)
                    .foregroundStyle(.gray1)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                
                Spacer()
                
                //INDICATOR
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(selectedPage == index ? Color.black : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 16)
                
                //BUTTON
                Component.DefaultButton(text: (selectedPage != 3) ? "Next" : "Let's Get Started", buttonLevel: .primary) {
                    if selectedPage < 3 {
                        selectedPage += 1
                    } else {
                        router.path.append(Page.Login)
                    }
                }
                .padding(.top, 60)
                
                Spacer()
            }
            .frame(width: 342, height: 274)
            .padding(.bottom, 61)

        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Router())
}
