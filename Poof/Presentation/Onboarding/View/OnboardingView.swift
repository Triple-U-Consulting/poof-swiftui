//
//  OnboardingView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @State private var selectedPage = 0
    private let numberOfOnboardingSlides : Int = 2
    
    private var title : [String] = [
        "AiroPuff",
        "Inhaler Pintar"
    ]
    private var details : [String] = [
        "AiroPuff adalah aplikasi yang dibuat untuk membantu masyarakat memantau kondisi asmanya.",
        "Inhaler pintar akan memantau penggunaan harian. Data akan tersinkronisasi otomatis saat aplikasi dibuka."
    ]
    
    var body: some View {
        VStack (spacing:0) {
            //IMAGExs
            TabView(selection: $selectedPage) {
                ForEach(0..<numberOfOnboardingSlides) { index in
                    Image("onboardingArtwork-\(index+1)")
                        .resizable()
                        .frame(width: userDevice.usableWidth, height: userDevice.height402)
                        .tag(index)
                }
            }
            .frame(height: userDevice.height402)
            .padding(.top, 102 - userDevice.topSafeArea)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
            
            //DETAILS
            VStack (spacing:0) {
                Component.DefaultText(text: title[selectedPage])
                    .frame(width: userDevice.width342, alignment: .center)
                    .font(.systemTitle2)
                    .foregroundStyle(.black)
                
                Component.DefaultText(text: details[selectedPage])
                    .lineLimit(3...3)
                    .font(.systemBodyText)
                    .frame(width: userDevice.width342, alignment: .center)
                    .foregroundStyle(Color.Neutrals.gray1)
                    .padding(.top, 12)
                
                Spacer()
                
                //BUTTON
                Component.DefaultButton(text: (selectedPage != numberOfOnboardingSlides-1) ? NSLocalizedString("Berikutnya", comment:"") : NSLocalizedString("Mulai", comment:""), buttonLevel: .primary) {
                    if selectedPage < 1 {
                        selectedPage += 1
                    } else {
                        router.path.append(Page.Login)
                    }
                }
            }
            .padding(.top, 5)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
        .environment(\.locale, .init(identifier: "en"))
}
