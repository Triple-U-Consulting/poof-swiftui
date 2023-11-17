//
//  DoseView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 10/11/23.
//

import SwiftUI

struct DoseView: View {
    
    @State private var remainingDose: String = ""
    @EnvironmentObject var router: Router
    @StateObject var vm = InhalerDoseViewModel()
    @FocusState var isInputActive: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 0){
                    TextField(text: $remainingDose) {
                        Text(verbatim: "Enter your remaining inhaler dose")
                    }
                    .focused($isInputActive)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .padding(.leading, 30)
                    .textFieldStyle(.automatic)
                    .padding(.vertical, 12)
                    .padding(.leading, -10)
                    .keyboardType(.numberPad)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.primary1, lineWidth: 2)
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    
                    Spacer()
                    
                    Component.DefaultButton(text: "Berikutnya", buttonLevel: .primary, buttonState: .active) {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        vm.updateDose(dose: Int(remainingDose)!)
                    }
                    .padding(.bottom, 44)
                    .padding(.horizontal, 24)
                }
                
                if vm.isPopUpDisplayed {
                    LoadingView()
                        .background(Color.black.opacity(0.4))
                        .edgesIgnoringSafeArea(.all)
                }
                
                
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Masukkan Sisa Dosis Inhaler")
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Selesai") {
                        isInputActive = false
                    }
                }
            }
            .background(.gray8)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.keyboard)
        }
        .onChange(of: vm.status) { _, newValue in
            if newValue == .success {
                router.path.append(Page.TabBar)
            }
        }
    }
}

#Preview {
    DoseView()
        .environmentObject(Router())
}
