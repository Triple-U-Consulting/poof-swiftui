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
            VStack (spacing: 0) {
                //CIRCLE INDICATOR
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
                    
                    Component.RotatingCircle(syncStatus: .constant(.synced))
                    Component.CircleView(
                        text: "Sinkronisasi",
                        syncStatus: .constant(.synced),
                        todayIntake: .constant(8),
                        remainingIntake: .constant(100))
                }
                .frame(width: 260, height: 260)
                .padding(.top, -28)
                
                //LAST SYNC
                Text("Terakhir disinkronisasi pada \(vm.syncDate)")
                    .padding(.top, 12)
                
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
                            Component.DefaultText(text: (vm.weekAvgPuff != nil ? "\(vm.weekAvgPuff!)" : "0"))
                                .font(.systemTitle2)
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
                            Component.DefaultText(text: (vm.remaining != nil ? "\(vm.remaining!)" : "0"))
                                .font(.systemTitle2)
                        }
                        .frame(width: 90, height:65)
                        
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
                }
                .padding(.top, 12)
                .padding(.horizontal, 24)
                
                Component.DefaultButton(text: "Ganti Inhaler", buttonLevel: .secondary) {
                    //TODO: LOGIC GANTI INHALER
                }
                .padding(.top, 12)
                .padding(.horizontal, 24)
                
                //CONDITION UPDATE FORM
                HStack {
                    Component.DefaultText(text: "Perbaharui Kondisi")
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
                    Component.DefaultText(text: "5 Puff terdeteksi")
                        .padding(.top, 8)
                        .padding(.leading, 12)
                }
                .padding(12)
                .background(.white)
                .cornerRadius(12)
                .frame(width: 342, height: 71)
                .padding(.top, 8)
                .onTapGesture {
                    router.path.append(Page.UpdateCondition)
                }
                
                Text(" ")
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Obat", fontSize: .systemTitle1)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .frame(width: userDevice.usableWidth)
            .background(.gray7)
        }
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
