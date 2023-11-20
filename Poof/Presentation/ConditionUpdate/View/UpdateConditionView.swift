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
        ZStack {
            Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
            NavigationView{
                ZStack {
                    Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
                    ScrollView{
                        LazyVStack(alignment: .leading){
                        
                            ForEach(vm.getDateKeys(), id: \.self) { key in
                                Component.DefaultText(text: "\(NSLocalizedString("Dilacak pada", comment: "")) \(DateFormatUtil.shared.dateToString(date: key, to: "dd MMMM yyyy"))")
                                    .font(.systemHeadline)
                                    .padding(.bottom, 24)
                                
                                UpdateConditionPerDateView(key: key)
                                    .environmentObject(vm)
                            }
                            
                        }
                        .toolbar{
                            ToolbarItem(placement: .topBarTrailing) {
                                Component.TextButton(text: "Simpan", action: {
                                    showFirstAlert = true
                                })
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
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
    }
}

#Preview {
    UpdateConditionView(showUpdateSheet: .constant(true))
        .environmentObject(ConditionViewModel())
}

struct UpdateConditionPerDateView: View {
    @EnvironmentObject var vm: ConditionViewModel
    
    let key: Date
    
    var body: some View {
        VStack {
            ForEach(0..<(vm.processedKambuhData[key]?.count ?? 0), id: \.self) { idx in
                HStack {
                    HStack{
                        Image(systemName: "clock").foregroundColor(Color.Main.blueTextSecondary)

                        Text("\(DateFormatUtil.shared.dateToString(date: vm.processedKambuhData[key]![idx].start, to: "HH.mm"))")
                            .padding(.leading, -3)

                    }

                    Spacer()

                    Text("\(vm.processedKambuhData[key]![idx].totalPuff) \(NSLocalizedString("puff terdeteksi", comment: ""))")
                }
                .padding()
                .frame(height: 45)
                .background(Color.Main.backgroundTitleCard)
                .cornerRadius(10)

                UpdateConditionCard(key: key, idx: idx)
                    .environmentObject(vm)
                    .padding(.bottom, 24)
                    .padding(.top, -14)
            }
        }
    }
}
