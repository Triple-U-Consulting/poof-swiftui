////
////  UpdateConditionCard.swift
////  Poof
////
////  Created by Geraldy Kumara on 07/11/23.
////
//
//import SwiftUI
//
//struct UpdateConditionCard: View {
//    @EnvironmentObject var vm: ConditionViewModel
//    @State private var isSelected: Bool = false
//    
//    let key: Date
//    let idx: Int
//    
//    var body: some View {
//        ZStack {
//            Color(.white).ignoresSafeArea()
//            VStack (alignment: .leading){
//                
//                HStack{
//                    Text("\(NSLocalizedString("Skala sesak", comment: ""))")
//                        .font(.systemBodyText)
//                    
//                    Text("\(vm.processedKambuhData[key]![idx].scale ?? 0)")
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                        //.padding(EdgeInsets(top: -5, leading: 0, bottom: 5, trailing: 8))
//                }
//                .padding(.bottom, 15)
//                .padding(.top, 12)
//                
//                Slider(
//                    value: Binding(
//                        get: { Double(vm.processedKambuhData[key]![idx].scale ?? 0) },
//                        set: { vm.processedKambuhData[key]![idx].scale = Int($0) }
//                    ),
//                    in: 1...5,
//                    step: 1,
//                    minimumValueLabel: {
//                        ZStack {
//                            Image("MinimumLabelSlider")
//                                .resizable()
//                                .frame(width: 24, height: 25)
//                                .padding(.trailing, 0)
//                        }
//                    }(),
//                    maximumValueLabel: {
//                        ZStack {
//                            Image("MaximumLabelSlider")
//                                .resizable()
//                                .frame(width: 24, height: 25)
//                                .padding(.leading, 0)
//                        }
//                    }(),
//                    label: {
//                        //
//                    }
//                )
//                .accentColor(Color.Main.blueTextSecondary)
//                
//           
//                    
//                    Component.CustomDivider(width: 330)
//                
//                
//                HStack{
//                    Text("\(NSLocalizedString("Dipicu oleh alergi anda?", comment: ""))")
//                    Spacer()
//                    Menu {
//                        Button("\(NSLocalizedString("Iya", comment: ""))"){
//                            isSelected = true
//                            vm.processedKambuhData[key]![idx].trigger = true
//                        }
//                        .frame(maxWidth: 10)
//                        Button("\(NSLocalizedString("Tidak", comment: ""))") {
//                            isSelected = true
//                            vm.processedKambuhData[key]![idx].trigger = false
//                        }
//                        .frame(maxWidth: 10)
//                    } label: {
//                        Label(isSelected ? (vm.processedKambuhData[key]![idx].trigger  ?? false ? "\(NSLocalizedString("Iya", comment: ""))" : "\(NSLocalizedString("Tidak", comment: ""))") : "\(NSLocalizedString("Pilih", comment: ""))", image: "")
//                            .font(.systemBodyText)
//                            .foregroundColor(.black)
//                            .padding(EdgeInsets(top: 6, leading: 4, bottom: 6, trailing: 12))
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.Main.primary1)
//                            }
//                    }
//                    .padding(.trailing, 2)
//                    .menuOrder(.fixed)
//                }
//                .padding(.top, 8)
////                .padding(EdgeInsets(top: 14, leading: 0, bottom: 12, trailing: 0))
//            }
//            .cornerRadius(10)
//            .padding(8)
//            .frame(width: 342, height: 164)
//        }
//    }
//}
//
////#Preview {
////    UpdateConditionCard(idx: 0)
////        .environmentObject(ConditionViewModel())
////}
