//
//  IrritantsView.swift
//  Poof
//
//  Created by Angelica Patricia on 21/11/23.
//

import SwiftUI

struct IrritantsView: View {
    
    @State private var iritansSelected: Array = []
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = IrritantsViewModel()
    let columns: [GridItem] = Array(repeating: .init(.flexible(),spacing: 0), count: 3)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray8
                    .ignoresSafeArea()
                
                VStack {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.items) { item in
                            Button(action: {
                                viewModel.toggleSelection(for: item.id)
                            }) {
                                Image(item.isSelected ? item.selected : item.unselected)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                
            }
            
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Pemicu Asma")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: "Simpan") {
                        viewModel.printTriggers()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    IrritantsView()
        .environmentObject(Router())
}
