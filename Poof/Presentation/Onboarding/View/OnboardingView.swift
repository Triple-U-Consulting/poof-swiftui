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
    
    private var title : [String] = [
        "AiroPuff",
        "Sambungkan Inhaler Pintar Anda",
        "Notifikasi Pengingat"
    ]
    private var details : [String] = [
        "Airopuff merupakan aplikasi yang dirancang untuk membantu orang tua memantau kondisi asma anak.",
        "Inhaler kami akan memantau pemakaian harian dan menyediakan informasi mengenai suhu ruangan anda.",
        "Kami akan mengingatkan anda untuk meminum obat dan melakukan singkronisasi setiap hari."
    ]
    
    
    var body: some View {
        VStack (spacing:0) {
            //IMAGE
            TabView(selection: $selectedPage) {
                ForEach(0..<3) { index in
                    Image("onboardingArtwork-\(index+1)")
                        .resizable()
                        .frame(width: userDevice.usableWidth, height: 402)
                        .tag(index)
                }
            }
            .frame(height: 402)
            .padding(.top, 102 - userDevice.topSafeArea)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
            
            //DETAILS
            VStack (spacing:0) {
                Text("\(userDevice.usableWidth)")
                Component.DefaultText(text: title[selectedPage])
                    .frame(width: 342, alignment: .center)
                    .font(.systemTitle2)
                    .foregroundStyle(.black)
                
                Component.DefaultText(text: details[selectedPage])
                    .frame(width: 342, alignment: .center)
                    .frame(minHeight: 70)
                    .font(.systemBodyText)
                    .foregroundStyle(.gray1)
                    .padding(.top, 12)
                
                //INDICATOR
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(selectedPage == index ? Color.black : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 32)
                
                //BUTTON
                Component.DefaultButton(text: (selectedPage != 2) ? "Berikutnya" : "Mulai", buttonLevel: .primary) {
                    if selectedPage < 2 {
                        selectedPage += 1
                    } else {
                        router.path.append(Page.Login)
                    }
                }
                .padding(.top, 68)
                
                Spacer()
            }
            .frame(height: 254)
            .padding(.top, 5)
            
            Spacer()

        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
