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
    
    var body: some View {
        ZStack {
            VStack {
                TextField(text: $remainingDose) {
                    Text(verbatim: "Enter your remaining inhaler dose")
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .padding(.leading, 30)
                .textFieldStyle(.automatic)
                .padding(.vertical, 12)
                .padding(.leading, -10)
                .keyboardType(.numberPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.primary2, lineWidth: 2)
                )
                
                Component.DefaultButton(text: "Next", buttonLevel: .primary, buttonState: .active) {
    //                pairProgress = .irritant
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    vm.updateDose(dose: Int(remainingDose)!)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            if vm.isPopUpDisplayed {
                LoadingView(dismissAction: {
                    vm.isPopUpDisplayed = false
                })
                .background(Color.black.opacity(0.4))
                .edgesIgnoringSafeArea(.all)
            }
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