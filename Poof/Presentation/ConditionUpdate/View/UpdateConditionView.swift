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
    //@State private var date: Date = Date()
//    @State private var pick: [Double] = []
//    @State private var selectMenu: [Bool] = []
    
    var body: some View {
        ZStack {
            Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
            NavigationView{
                ZStack {
                    Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
                    ScrollView{
                        LazyVStack(alignment: .leading){
                            
                            ForEach(vm.sameDate.indices, id: \.self){ idx in
                              
                            }
//                            Text(("\(NSLocalizedString("Dilacak pada", comment: "")) \(DateFormatUtil.shared.dateToString(date: date, to:  "dd MMMM yyyy"))"))
//                                .padding(.bottom, 32)
                            
                            
                            
                            ForEach(vm.kambuhList.indices, id: \.self) { idx in
                                
                                HStack {
                                    HStack{
                                        Image(systemName: "clock").foregroundColor(Color.Main.blueTextSecondary)
                                        
                                        Text("\(DateFormatUtil.shared.dateToString(date: vm.kambuhList[idx].start, to: "HH.mm"))")
                                            .padding(.leading, -3)
                
                                    }
                                    
                                    Spacer()
                                    
                                    Text("\(vm.kambuhList[idx].totalPuff) \(NSLocalizedString("puff terdeteksi", comment: ""))")
                                }
                                
                                UpdateConditionCard(idx: idx)
                                    .environmentObject(vm)
                                    .padding(.bottom, 24)
                                
                            }
                            
//                            Component.DefaultButton(text: "Fetch") {
//                                vm.fetchKambuhDataByDate(date: date)
//                            }
                            
                        }
                        .toolbar{
                            ToolbarItem(placement: .topBarTrailing) {
                                Component.TextButton(text: NSLocalizedString("Simpan", comment: ""), action: {
                                    vm.updateKambuhData()
                                    router.path.append(Page.TabBar)
                                })
                            }
                        }
                    }
                }
            }
            .onAppear(perform: {
                vm.fetchKambuhDataIfScaleAndTriggerIsNull()
                //print(date)
            })
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }
}

#Preview {
    UpdateConditionView()
        .environmentObject(ConditionViewModel())
        .environmentObject(Router())
}
