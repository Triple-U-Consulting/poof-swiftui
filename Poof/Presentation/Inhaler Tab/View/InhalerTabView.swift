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
    @State private var showUpdateSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack (spacing: 0) {
                    //CIRCLE INDICATOR
                    VStack (spacing: 0) {
                        HStack (alignment: .top, spacing: 0) {
                            //CIRLCE
                            ZStack (alignment: .center) {
                                Component.RotatingCircle(syncStatus: $vm.syncStatus)
                                Component.CircleView(
                                    text: "Sinkronisasi",
                                    syncStatus: $vm.syncStatus,
                                    todayIntake: Binding(
                                        get: {
                                            CGFloat(vm.todayPuff ?? 0)
                                        },
                                        set: { _ in }
                                    ),
                                    remainingIntake: Binding(
                                        get: {
                                            CGFloat(vm.remaining ?? 0)
                                        },
                                        set: { _ in }
                                    ))
                                .padding(.all, 18)
                            }
                            .frame(width: 104, height: 104)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            
                            //DATA
                            VStack (alignment:.leading, spacing: 0) {
                                Spacer()
                                Component.DefaultText(text: "Spray Remaining")
                                    .font(.systemBodyText)
                                
                                Component.DefaultText(text: (vm.remaining != nil ? "\(vm.remaining!)" : "0"))
                                    .font(.custom(size: 28, weight: .bold))
                                    .padding(.top, 2)
                                
                                HStack (spacing: 0) {
                                    Component.DefaultText(text: "Status: ")
                                        .font(.systemBodyText)
                                    
                                    Component.DefaultText(text: (vm.remaining != nil ? (vm.remaining! < 66 ? "Low" : vm.remaining! < 132 ? "Medium" : "Safe") : "Unknown"))
                                        .font(.systemBodyText)
                                        .bold()
                                        .foregroundStyle((vm.remaining != nil ? (vm.remaining! < 66 ? .red : vm.remaining! < 132 ? .orange : .green) : .black))
                                    
                                    Image(systemName:"exclamationmark.triangle.fill")
                                        .resizable()
                                        .frame(width:16, height:16)
                                        .foregroundStyle((vm.remaining != nil ? (vm.remaining! < 66 ? .red : vm.remaining! < 132 ? .orange : .green) : .black))
                                        .padding(.leading, 4)
                                    Spacer()

                                }
                                .padding(.top, 2)
                                
                                HStack (spacing: 0){
                                    Image(systemName: "clock.arrow.2.circlepath")
                                        .resizable()
                                        .frame(width: 14, height: 12)
                                        .foregroundStyle(.gray1)
                                    
                                    Component.DefaultText(text: vm.syncDate == "" ? " Belum pernah disinkronkan" : " Terakhir disinkronisasi pada \(vm.syncDate)")
                                        .font(.custom(size: 10, weight: .regular))
                                        .foregroundStyle(.gray1)
                                }
                                .padding(.top, 12)
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        
                    }
                    .frame(width:342)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.top, 16)
                    
                    //HIGHLIGHTS
                    VStack (spacing:0) {
                        HStack (alignment: .center, spacing: 0) {
                            Spacer()
                            Spacer()
                            VStack (alignment: .center) {
                                Component.DefaultText(text: "Pemakaian Hari Ini")
                                    .font(.systemFootnote)
                                    .lineLimit(2...)
                                Component.DefaultText(text: (vm.todayPuff != nil ? "\(vm.todayPuff!)" : "0"))
                                    .font(.systemTitle1)
                            }
                            .frame(width: 155, height:65)
                            
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
                                Component.DefaultText(text: (vm.weekAvgPuff != nil ? "\(vm.weekAvgPuff!)" : "0"))
                                    .font(.systemTitle1)
                            }
                            .frame(width: 155, height:65)
                            
                            Spacer()
                            Spacer()
                            
                        }
                        .frame(width:342, height:101)
                        .background(.primary3.opacity(0.5))
                        .cornerRadius(10)
                    }
                    .frame(width: 342)
                    .padding(.top, 16)
                    
                    //LOW INHALER WARNING
                    if let remainingPuff = vm.remaining {
                        if remainingPuff < 10 {
                            HStack {
                                Text(Image(systemName: "exclamationmark.triangle.fill"))
                                Component.DefaultText(text: " Inhaler Anda hampir habis")
                            }
                            .padding(.top, 12)
                        }
                    }
                    
                    //BUTTON
                    Component.DefaultButton(text: "Sinkronisasi", buttonLevel: .primary) {
                        vm.getData()
                        vm.fetchKambuhDataIfScaleAndTriggerIsNull()
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 24)
                    
                    Component.DefaultButton(text: "Ganti Inhaler", buttonLevel: .secondary) {
                        //TODO: LOGIC GANTI INHALER
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 24)
                    
                    //CONDITION UPDATE FORM
                    if vm.hasDataToBeFilled {
                        HStack {
                            Component.DefaultText(text: "Perbaharui Catatan Kondisi")
                                .font(.systemSubheader)
                            Spacer()
                        }
                        .frame(width: 342)
                        .padding(.top, 24)
                        
                        VStack (alignment: .leading, spacing:0) {
                            HStack {
                                Component.DefaultText(text: "Perbarui gejala anda")
                                    .foregroundStyle(.primary1)
                                Spacer()
                                Text(Image(systemName: "chevron.right"))
                                    .foregroundStyle(.primary1)
                            }
                            .padding(.horizontal, 12)
                            //TODO: JUMLAH DATA YANG BELUM DIISI
                            Component.DefaultText(text: "\(vm.processedKambuhData.values.first!.count) kali pemakaian")
                                .padding(.top, 8)
                                .padding(.leading, 12)
                        }
                        .padding(12)
                        .background(.white)
                        .cornerRadius(12)
                        .frame(width: 342, height: 71)
                        .padding(.top, 8)
                        .onTapGesture {
                            self.showUpdateSheet = true
                        }
                    }
                    
                    Spacer()
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Airo", fontSize: .systemTitle1)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .frame(width: userDevice.usableWidth)
            .background(.gray7)
            .sheet(isPresented: $showUpdateSheet, content: {
                UpdateConditionView(showUpdateSheet: $showUpdateSheet)
                    .interactiveDismissDisabled()
                    .environmentObject(router)
                    .navigationBarHidden(true)
            })
        }
        .onAppear {
            vm.getData()
            vm.fetchKambuhDataIfScaleAndTriggerIsNull()
        }
    }
}


#Preview {
    InhalerTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}
