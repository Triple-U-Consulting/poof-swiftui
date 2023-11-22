//
//  IrritantsView.swift
//  Poof
//
//  Created by Angelica Patricia on 21/11/23.
//

import SwiftUI

struct IrritantsView: View {
    @State var other = ""
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
                    
                    TextField("Ketik di sini", text: $other, axis: .vertical)
                        .padding()
                        .lineLimit(5, reservesSpace: true)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(.primary1, lineWidth: 1).fill(.white))
                        .padding()
                    
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
                        router.path.append(Page.TabBar)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        router.path.removeLast()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .foregroundColor(.black)
                            .padding(.leading)
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
