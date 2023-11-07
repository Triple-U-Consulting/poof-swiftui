//
//  InhalerTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct InhalerTabView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @StateObject var vm = InhalerTabViewModel()
    @State private var inhalerSegment = 0
    
    var body: some View {
        NavigationView {
            VStack (spacing:0) {
                
                Picker("What is your favorite color?", selection: $inhalerSegment) {
                    Text("Kambuh").tag(0)
                    Text("Harian").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(width: 342, height: 34)
                .padding(.top, 16)
            
                ZStack (alignment: .center) {
                    Component.RotatingCircle(syncStatus: $vm.syncStatus)
                    Component.CircleView(text: "Sinkronisasi")
                }
                .frame(width: 260, height: 260)
                .padding(.top, 16)
                
                Text("Last sync on \(vm.syncDate)")
                    .padding(.top, 12)
                
                VStack (spacing:0) {
                    
                    //TODAY'S DATA
                    HStack (alignment: .top, spacing: 0) {
                        
                        Spacer()
                        Spacer()
                        
                        VStack (alignment: .center) {
                            Component.DefaultText(text: "Pemakaian Hari Ini")
                                .font(.systemFootnote)
                                .lineLimit(2...)
                            Component.DefaultText(text: (vm.todayPuff != nil ? "\(vm.todayPuff!)" : ""))
                                .font(.systemTitle2)
                        }
                        .frame(width: 90, height:65)
                        
                        Spacer()
                        Divider()
                            .frame(width: 2, height: 85)
                            .background(.primary2)
                        Spacer()
                        
                        VStack (alignment: .center) {
                            Component.DefaultText(text: "Pemakaian Rata-Rata")
                                .font(.systemFootnote)
                                .multilineTextAlignment(.center)
                                .lineLimit(2...)
//                                .background(.yellow)
                            Component.DefaultText(text: (vm.weekAvgPuff != nil ? "\(vm.weekAvgPuff!)" : ""))
                                .font(.systemTitle2)
//                                .background(.red)
                        }
                        .frame(width: 90, height:65)
                        
                        Spacer()
                        Divider()
                            .frame(width: 2, height: 85)
                            .background(.primary2)
                        Spacer()
                        
                        VStack (alignment: .center)  {
                            Component.DefaultText(text: "Sisa Obat")
                                .font(.systemFootnote)
                                .multilineTextAlignment(.center)
                                .lineLimit(2...)
                            Component.DefaultText(text: (vm.remaining != nil ? "\(vm.remaining!)" : ""))
                                .font(.systemTitle2)
                        }
                        .frame(width: 90, height:65)
                        
                        Spacer()
                        Spacer()
                        
                    }
                    .frame(width:342, height:101)
                    .background(.primary3.opacity(0.5))
                    .cornerRadius(10)
//                    .shadow(color: .gray3, radius: 12, x: 0, y: 4)
                    .padding(.top, 16)
                    
                    //STATUS
//                    VStack (alignment: .leading, spacing:0) {
//                        Component.DefaultText(text: "Status")
//                            .font(.systemHeadline)
//                        
//                        HStack (spacing:0) {
//                            Component.DefaultText(text: "Last Replaced Date")
//                                .font(.systemFootnote)
//                            Spacer()
//                            Component.DefaultText(text: "15/08/2023")
//                                .font(.systemFootnote)
//                        }
////                        .background(.yellow)
//                        .padding(.top, 8)
//                        
//                        
//                        HStack (spacing:0) {
//                            Component.DefaultText(text: "Expected Replace Date")
//                                .font(.systemFootnote)
//                            Spacer()
//                            Component.DefaultText(text: "29/09/2023")
//                                .font(.systemFootnote)
//                        }
////                        .background(.yellow)
//                        .padding(.top, 8)
//                        
//                    }
//                    .padding(.top, 16)
                    
                    //BUTTON
                    Component.DefaultButton(text: "Sync", buttonLevel: .primary) {
                        vm.getData()
                    }
                    .padding(.top, 16)
                    
                }
                .frame(width: 342, height:249)
                .padding(.top, 18)
                
                Spacer()
                
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.NavigationTitle(text: "Inhaler")
//                        .padding(.top, 16)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Component.ProfileButton() {
                        //logic
                    }
//                    .padding(.top, 8)
                }
            }
            //            .background(.red)
            //            .navigationTitle("Inhaler")
            //            .navigationBarHidden(true)
            //            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(8)
        .onAppear {
            vm.getData()
        }
    }
}


#Preview {
    InhalerTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
