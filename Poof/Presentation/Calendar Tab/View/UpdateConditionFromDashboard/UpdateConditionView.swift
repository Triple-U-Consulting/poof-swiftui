//
//  MockViewCondition.swift
//  Poof
//
//  Created by Geraldy Kumara on 06/11/23.
//

import SwiftUI
import Combine

struct UpdateConditionView: View {
    @State var showFirstAlert: Bool = false
    @State var showSecondAlert: Bool = false
    @Binding var showUpdateSheet: Bool
    @StateObject var vm: ConditionViewModel = ConditionViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing:0) {

                    ForEach(vm.getDateKeys(), id: \.self) { key in
                        VStack (alignment: .leading, spacing:0) {
                            Component.DefaultText(
                                text: "Dilacak pada \(DateFormatUtil.shared.dateToString(date: key, to: "dd MMMM yyyy"))"
                            )
                                .font(.systemHeadline)
                                .padding(.bottom, 12)
                            
                            UpdateConditionPerDateView(key: key)
                                .environmentObject(vm)
                        }

                    }
                    .padding(.horizontal, 16)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.TextButton(text: "Delete", color: .red, action: {
                        //delete
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Component.DefaultText(text: "Perbarui Kondisi")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: "Simpan", action: {
                        showFirstAlert = true
                    })
                }
            }
            .onAppear {
                vm.fetchKambuhDataIfScaleAndTriggerIsNull()
            }
            .alert(Text(NSLocalizedString("Sepertinya anda belum mengisi semua catatan!", comment: "")), isPresented: $showSecondAlert, actions: {
                Button(action: {
                    self.showUpdateSheet.toggle()
                }, label: {
                    Text("OK")
                })
            }, message: {
                Text(NSLocalizedString("Anda bisa membuat perubahan kembali di halaman Kalender", comment: ""))
            })
            .confirmationDialog(NSLocalizedString("Pastikan data yang diisi sudah sesuai", comment: ""), isPresented: $showFirstAlert, actions: {
                Button {
                    vm.updateKambuhData()
                    
                    if vm.hasDataToBeFilled() {
                        showSecondAlert = true
                    } else {
                        self.showUpdateSheet.toggle()
                    }
                } label: {
                    Text(NSLocalizedString("Ya, simpan perubahan", comment: ""))
                }
            }, message: {
                Text(NSLocalizedString("Pastikan data yang diisi sudah sesuai", comment: ""))
            })
            .background(.gray7)
        }
        .ignoresSafeArea()
        .presentationDetents([.height(500), .large])
        .presentationDragIndicator(.visible)
    }
}


#Preview {
    UpdateConditionView(showUpdateSheet: .constant(true))
        .environmentObject(ConditionViewModel())
}

struct UpdateConditionPerDateView: View {
    @EnvironmentObject var vm: ConditionViewModel
    
    @State private var selectedIrritant: String = "Choose"
    @State private var skalaSesak: Double = 0
    @State private var showSkalaSesak: Bool = false
    @State private var noSkalaSesak: Bool = false

    @State private var isSelected: Bool = false
    
    let key: Date
    
    var body: some View {
        VStack (spacing:0) {
            ForEach(0..<(vm.processedKambuhData[key]?.count ?? 0), id: \.self) { idx in
                List {
                    VStack (spacing:0) {
                        
                        HStack (spacing:0) {
                            Text(Image(systemName: "clock"))
                                .font(.systemHeadline)
                                .foregroundColor(.primary1)
                            Component.DefaultText(text: "\(DateFormatUtil.shared.dateToString(date: vm.processedKambuhData[key]![idx].start, to: "HH.mm"))")
                                .font(.systemHeadline)
                                .foregroundColor(.black)
                            Spacer()
                            Component.DefaultText(text: "\(vm.processedKambuhData[key]![idx].totalPuff) \(NSLocalizedString("puff terdeteksi", comment: ""))")
                                .font(.systemHeadline)
                                .foregroundColor(.black)
                        }
                        .padding(.all, 12)
                    }
                    .frame(width: .infinity)
                    .background(.primary3)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 10,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 10
                        )
                    )
                    .ignoresSafeArea()
                    .listRowInsets(EdgeInsets())
                    
                    HStack {
                        Component.DefaultText(text: "Skala Sesak")
                        
                        Spacer()
                        Component.TextWithBorder(text: "\(vm.processedKambuhData[key]![idx].scale ?? 0)")
                            .onTapGesture {
                                showSkalaSesak.toggle()
                            }
                    }
                    
                    if showSkalaSesak {
                        Component.FormSlider(
                            value: Binding(
                                get: { Double(vm.processedKambuhData[key]![idx].scale ?? 0) },
                                set: { vm.processedKambuhData[key]![idx].scale = Int($0) }
                            ),
                            toggle: $noSkalaSesak
                        )
                    }
                    
                    HStack {
                        Component.DefaultText(text: "Alergen")
                        Spacer()
                        Component.MenuWithBorder(selection: $selectedIrritant, menuSelection: .constant(["Pollen", "Pet", "Exercise", "Others"]))
                    }
                    

//                    HStack{
//
//                        Menu {
//                            Button("\(NSLocalizedString("Iya", comment: ""))"){
//                                isSelected = true
//                                vm.processedKambuhData[key]![idx].trigger = true
//                            }
//                            .frame(maxWidth: 10)
//                            Button("\(NSLocalizedString("Tidak", comment: ""))") {
//                                isSelected = true
//                                vm.processedKambuhData[key]![idx].trigger = false
//                            }
//                            .frame(maxWidth: 10)
//                        } label: {
//                            Label(isSelected ? (vm.processedKambuhData[key]![idx].trigger  ?? false ? "\(NSLocalizedString("Iya", comment: ""))" : "\(NSLocalizedString("Tidak", comment: ""))") : "\(NSLocalizedString("Pilih", comment: ""))", image: "")
//                                .font(.systemBodyText)
//                                .foregroundColor(.black)
//                                .padding(EdgeInsets(top: 6, leading: 4, bottom: 6, trailing: 12))
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.Main.primary1)
//                                }
//                        }
//                        .padding(.trailing, 2)
//                        .menuOrder(.fixed)
//                    }
//                    .padding(.top, 8)
//                    
//                    UpdateConditionCard(key: key, idx: idx)
//                        .environmentObject(vm)
//                        .padding(.bottom, 24)
//                        .padding(.top, -14)
                }
            }
        }
    }
}

