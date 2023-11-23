//
//  CalendarAddSheetView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 21/11/23.
//

import SwiftUI

struct CalendarAddSheetView: View {
    @EnvironmentObject private var calendarVM: CalendarViewModel
    
    var datePicked: Date
    @Binding var showSheet: Bool
    @Binding var showAddSheet: Bool
    @State var showTimePicker: Bool = false
    @State var showSkalaSesak: Bool = false
    @State var sprayCount: Int = 0
    @State var selectedIrritant: String = "Choose"
    @State var skalaSesak: Double = -1
    @State var noSkalaSesak: Bool = false
    @StateObject private var vm = CalendarAddSheetViewModel()
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Component.DefaultText(text: "Waktu")
                        Spacer()
                        Component.TextWithBorder(text: "\(vm.time.hourMinute)")
                            .onTapGesture {
                                showTimePicker.toggle()
                            }
                    }
                    
                    if showTimePicker {
                        DatePicker("", selection: $vm.time, displayedComponents: DatePickerComponents.hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    HStack {
                        Component.DefaultText(text: "Spray")
                        Spacer()
                        Component.Stepper(value: $sprayCount)
                    }
                }

                Section {
                    HStack {
                        Component.DefaultText(text: "Skala Sesak")
                        Spacer()
                        Component.TextWithBorder(text: "\(vm.labelSkalaSesak[Int(skalaSesak)]!)")
                            .onTapGesture {
                                showSkalaSesak.toggle()
                                if skalaSesak == -1 {
                                    skalaSesak = 0
                                }
                            }
                    }
                    
                    if showSkalaSesak {
                        Component.FormSlider(value: $skalaSesak, toggle: $noSkalaSesak)
                            .onChange(of: noSkalaSesak) { oldValue, newValue in
                                if newValue == true { //if true
                                    skalaSesak = -2
                                } else {
                                    skalaSesak = 0
                                }
                            }
                    }
                        
                    HStack {
                        Component.DefaultText(text: "Alergen")
                        Spacer()
                        Component.MenuWithBorder(selection: $selectedIrritant, menuSelection: .constant(["Pollen", "Pet", "Exercise", "Others"]))
                    }
                }
                
        
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Component.TextButton(text: "Batal", color: .red, action: {
                        showAddSheet.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                            showSheet.toggle()
                        })
                    })
                }
                ToolbarItem(placement: .principal) {
                    Component.DefaultText(text: "Penggunaan Baru")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: "Simpan", action: {
                        let datetimeyuhu = datePicked.fullDate + "T" + vm.time.fullTime + "Z"; print(datetimeyuhu)
                        //TODO: LOGIC SAVE
                        vm.addKambuh(start_time: datetimeyuhu
                                     , total_puff: sprayCount, scale: vm.labelSkalaSesak[Int(skalaSesak)]!, trigger: selectedIrritant)
                        
                        showAddSheet.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                            showSheet.toggle()
                        })
                    })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.gray7)
        }
        .frame(width: .infinity)
        .ignoresSafeArea()
        .presentationDetents([.large, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    CalendarAddSheetView(datePicked: Date(), showSheet: .constant(true), showAddSheet: .constant(true))
        .environmentObject(CalendarViewModel())
}
