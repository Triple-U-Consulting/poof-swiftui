//
//  UpdateConditionFromCalendar.swift
//  Poof
//
//  Created by Angela Christabel on 09/11/23.
//

import SwiftUI

struct UpdateConditionFromCalendarView: View {
    @EnvironmentObject var vm: CalendarViewModel
    @State private var isSelected: Bool = false
    
    let index: Int
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack (alignment: .leading) {
                
                Text("\(NSLocalizedString("Memperbaharui kondisi", comment: ""))")
                    .font(.systemBodyText)
                    .padding(.bottom, 15)
                    .padding(.top, 12)
                
                Slider(
                    value: Binding(
                        get: { Double(vm.getCurrentKambuh(index: index).scale ?? 0) },
                        set: { vm.processedKambuhData[vm.currentDateSelected]![index].scale = Int($0) }
                    ),
                    in: 1...5,
                    step: 1,
                    minimumValueLabel: {
                        ZStack {
                            Image("MinimumLabelSlider")
                                .resizable()
                                .frame(width: 24, height: 25)
                                .padding(.trailing, 0)
                        }
                    }(),
                    maximumValueLabel: {
                        ZStack {
                            Image("MaximumLabelSlider")
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
                
                VStack {
                    Text("\(vm.getCurrentKambuh(index: index).scale ?? 0)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, -5)
                        .padding(.bottom, 5)
                    
                    Component.CustomDivider(width: 330)
                }
                
                HStack{
                    Text("\(NSLocalizedString("Dipicu oleh alergi anda?", comment: ""))")
                    Spacer()
                    Menu {
                        Button("\(NSLocalizedString("Iya", comment: ""))"){
                            isSelected = true
                            vm.processedKambuhData[vm.currentDateSelected]![index].trigger = true
                        }
                        .frame(maxWidth: 10)
                        Button("\(NSLocalizedString("Tidak", comment: ""))") {
                            isSelected = true
                            vm.processedKambuhData[vm.currentDateSelected]![index].trigger = false
                        }
                        .frame(maxWidth: 10)
                    } label: {
                        Label(vm.getCurrentKambuh(index: index).trigger != nil ? (vm.getCurrentKambuh(index: index).trigger == true ? "\(NSLocalizedString("Iya", comment: ""))" : "\(NSLocalizedString("Tidak", comment: ""))") : "\(NSLocalizedString("Pilih", comment: ""))", image: "")
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
