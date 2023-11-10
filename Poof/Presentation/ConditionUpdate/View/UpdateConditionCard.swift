//
//  UpdateConditionCard.swift
//  Poof
//
//  Created by Geraldy Kumara on 07/11/23.
//

import SwiftUI

struct UpdateConditionCard: View {
    
    @EnvironmentObject var vm: ConditionViewModel
    @State private var isSelected: Bool = false
//    @Binding var pick: [Double]
//    @Binding var selectMenu: [Bool]
    var idx: Int
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack (alignment: .leading){
                
                Text("\(NSLocalizedString("Memperbaharui kondisi", comment: ""))")
                    .font(.systemBodyText)
                    .padding(.bottom, 15)
                    .padding(.top, 12)
                
                Slider(
                    value: Binding(
                        get: { Double(vm.scale[idx]) },
                        set: { vm.scale[idx] = Int($0) }
                    ),
                    in: 1...5,
                    step: 1,
                    minimumValueLabel: {
                        ZStack {
                            Image("minimumLabelSlider")
                                .resizable()
                                .frame(width: 24, height: 25)
                                .padding(.trailing, 0)
                        }
                    }(),
                    maximumValueLabel: {
                        ZStack {
                            Image("maximumLabelSlider")
                                .resizable()
                                .frame(width: 24, height: 25)
                                .padding(.leading, 0)
                        }
                    }(),
                    label: {
                        //
                    }
                )
                .accentColor(Color.Main.blueTextSecondary)
                
                Text("\(vm.scale[idx])")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, -5)
                    .padding(.bottom, 5)
                
                Component.CustomDivider(width: 330)
                
                HStack{
                    Text("\(NSLocalizedString("Dipicu oleh alergi anda?", comment: ""))")
                    Spacer()
                    Menu {
                        Button("\(NSLocalizedString("Iya", comment: ""))"){
                            isSelected = true
                            vm.trigger[idx] = true
                        }
                        .frame(maxWidth: 10)
                        Button("\(NSLocalizedString("Tidak", comment: ""))") {
                            isSelected = true
                            vm.trigger[idx] = false
                        }
                        .frame(maxWidth: 10)
                    } label: {
                        Label(isSelected ? (vm.trigger[idx] ? "\(NSLocalizedString("Iya", comment: ""))" : "\(NSLocalizedString("Tidak", comment: ""))") : "\(NSLocalizedString("Pilih", comment: ""))", image: "")
                            .font(.systemBodyText)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 6, leading: 4, bottom: 6, trailing: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.Main.primary1)
                            }
                    }
                    .padding(.trailing, 2)
                    .menuOrder(.fixed)
                }
//                .padding(EdgeInsets(top: 14, leading: 0, bottom: 12, trailing: 0))
            }
            .cornerRadius(10)
            .padding(8)
            .frame(width: 342, height: 174)
        }
    }
}

//#Preview {
//    UpdateConditionCard(idx: 0)
//        .environmentObject(ConditionViewModel())
//}
