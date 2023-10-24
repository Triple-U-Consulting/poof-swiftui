//
//  InhalerTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct InhalerTabView: View {
    
    @EnvironmentObject var router: Router
    @State private var didSync = true
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Component.RotatingCircle(didSync: $didSync)
                    //                Component.RotatingGradientCircle()
//                    Component.CircleButton(text: "", diameter: 247)
                    Component.CircleButton(text: "SYNC", diameter: 213, didSync: $didSync)
                }
                .padding(.top, 64)
                
                if didSync {
                    Text("Last sync on 8.39 am")
                        .padding(.top, 8)
                    
                    HStack (alignment: .top){
                        VStack (alignment: .center) {
                            Text("Today Puff")
                            Spacer()
                            Text("2")
                        }.frame(width: 90, height:80)
                        VStack (alignment: .center) {
                            Text("Average \nPuff")
                                .multilineTextAlignment(.center)
                            Spacer()
                            Text("9")
                        }.frame(width: 90, height:80)
                        VStack (alignment: .center)  {
                            Text("Remaining \nPuff")
                                .multilineTextAlignment(.center)
                            Spacer()
                            Text("102")
                        }.frame(width: 90, height:80)
                    }
                    .frame(width:342, height:101)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray3, radius: 12, x: 0, y: 4)
                    .padding(.top, 16)
                    
                    VStack {
                        HStack{
                            Text("Last Replaced Date")
                            Spacer()
                            Text("15-08-2023")
                        }
                        HStack {
                            Text("Expected Replace Date")
                            Spacer()
                            Text("29-09-2023")
                        }
                    }
                    .frame(width:302, height:40)
                    .padding(.vertical, 32)
                    
                    Spacer()
                    
                    Component.DefaultButton(text: "Sync", buttonLevel: .primary) {
                        //logic
                    }
                        .padding(.bottom, 16)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.NavigationTitle(text: "Inhaler")
                        .padding(.top, 16)
                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    Component.ProfileButton(text: "")
//                        .padding(.top, 8)
//                }
            }
//            .navigationTitle("Inhaler")
//            .navigationBarHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(8)
    }
}

#Preview {
    InhalerTabView()
        .environmentObject(Router())
    
}
