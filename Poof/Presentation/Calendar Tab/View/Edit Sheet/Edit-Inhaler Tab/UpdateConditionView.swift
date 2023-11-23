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
                    .padding(16)
                    .padding(.top, 0)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.TextButton(text: "Delete", color: .red, action: {
                        //delete
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Component.DefaultText(text: "Perbaharui Kondisi")
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
        .presentationDetents([.large, .large])
        .presentationDragIndicator(.hidden)
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
        VStack(spacing: 12) {
            ForEach(0..<(vm.processedKambuhData[key]?.count ?? 0), id: \.self) { idx in
                VStack(spacing: 0) {
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
                    .padding(12)
                    .background(.primary3)
                    
                    VStack(spacing: 12) {
                        SliderView(noSkalaSesak: $noSkalaSesak, key: key, idx: idx)
                            .environmentObject(vm)
                        
                        Divider()
                        
                        HStack {
                            Component.DefaultText(text: "Alergen")
                            Spacer()
                            Component.MenuWithBorder(selection: $selectedIrritant, menuSelection: .constant(["Pollen", "Pet", "Exercise", "Others"]))
                        }
                    }
                    .padding(12)
                }
                .background(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            }
        }
    }
}

