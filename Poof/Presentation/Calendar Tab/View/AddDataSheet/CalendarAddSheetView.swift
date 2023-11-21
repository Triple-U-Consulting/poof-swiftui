//
//  CalendarAddSheetView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 21/11/23.
//

import SwiftUI

struct CalendarAddSheetView: View {
    
    @Binding var showSheet: Bool
    @Binding var showAddSheet: Bool
    @State var time: Date = Date()
    @State var showTimePicker: Bool = false
    @State var showSkalaSesak: Bool = false
    
    @State var sprayCount: Int = 0
    @State var selectedIrritant: String = "Choose"
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Component.DefaultText(text: "Waktu")
                        Spacer()
                        Component.TextWithBorder(text: "\(time.hourMinute)")
                            .onTapGesture {
                                showTimePicker.toggle()
                            }
                    }
                    
                    if showTimePicker {
                        DatePicker("", selection: $time, displayedComponents: DatePickerComponents.hourAndMinute)
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
                        Component.TextWithBorder(text: "Moderate")
                            .onTapGesture {
                                showSkalaSesak.toggle()
                            }
                    }
                    
                    if showSkalaSesak {
                        Text("--------Slider sesak-------")
                    }
                        
                    HStack {
                        Component.DefaultText(text: "Alergen")
                        Spacer()
                        Component.MenuWithBorder(selection: $selectedIrritant, array: .constant(["Pollen", "Pet", "Exercise"]))
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
                        //TODO: LOGIC SAVE
                        
                        showAddSheet.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                            showSheet.toggle()
                        })
                    })
                }
            }
            .background(.gray7)
        }
        .frame(width: .infinity)
        .ignoresSafeArea()
        .presentationDetents([.height(500), .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    CalendarAddSheetView(showSheet: .constant(true), showAddSheet: .constant(true))
}
