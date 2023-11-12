//
//  MockViewCondition.swift
//  Poof
//
//  Created by Geraldy Kumara on 06/11/23.
//

import SwiftUI
import Combine

struct UpdateConditionView: View {
    @EnvironmentObject var vm: ConditionViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
            NavigationView{
                ZStack {
                    Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
                    ScrollView{
                        LazyVStack(alignment: .leading){
                        
                            ForEach(vm.getDateKeys(), id: \.self) { key in
                                Text(("\(NSLocalizedString("Dilacak pada", comment: "")) \(DateFormatUtil.shared.dateToString(date: key, to: "dd MMMM yyyy"))"))
                                    .padding(.bottom, 24)
                                
                                UpdateConditionPerDateView(key: key)
                                    .environmentObject(vm)
                            }
                            
                        }
                        .toolbar{
                            ToolbarItem(placement: .topBarTrailing) {
                                Component.TextButton(text: NSLocalizedString("Simpan", comment: ""), action: {
                                    vm.updateKambuhData()
                                    router.path.removeLast()
                                })
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }
}

#Preview {
    UpdateConditionView()
        .environmentObject(ConditionViewModel())
        .environmentObject(Router())
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
