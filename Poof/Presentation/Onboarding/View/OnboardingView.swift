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
    private var numberOfOnboardingSlides : Int = 2
    
    private var title : [String] = [
        "AiroPuff",
        "Sambungkan Inhaler Pintar Anda",
        "Notifikasi Pengingat"
    ]
    private var details : [String] = [
        "Airopuff merupakan aplikasi yang dirancang untuk membantu orang tua memantau kondisi asma anak.",
        "Inhaler pintar akan memantau pemakaian harian inhaler anda dan menyediakan informasi mengenai lingkungan sekitar anda.",
        "Kami akan mengirimkan anda pengingat untuk obat harian dan notifikasi ketika inhaler pintar digunakan."
    ]
    
    var body: some View {
        VStack (spacing:0) {
            //IMAGE
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
                    .foregroundStyle(.gray1)
                    .padding(.top, 12)
                
                //INDICATOR
//                HStack(spacing: 8) {
//                    ForEach(0..<numberOfOnboardingSlides) { index in
//                        Circle()
//                            .fill(selectedPage == index ? Color.black : Color.gray)
//                            .frame(width: 8, height: 8)
//                    }
//                }
//                .padding(.top, 32)
                
                Spacer()
                
                //BUTTON
                Component.DefaultButton(text: (selectedPage != numberOfOnboardingSlides-1) ? NSLocalizedString("Berikutnya", comment:"") : NSLocalizedString("Mulai", comment:""), buttonLevel: .primary) {
                    if selectedPage < 2 {
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
