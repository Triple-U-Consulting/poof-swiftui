//
//  IrritantsView.swift
//  Poof
//
//  Created by Angelica Patricia on 21/11/23.
//

import SwiftUI

struct IrritantsView: View {
    @State var other = ""
    @State private var otherSelected: Bool = false
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = IrritantsViewModel()
    let columns: [GridItem] = Array(repeating: .init(.flexible(),spacing: 8), count: 3)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray8
                    .ignoresSafeArea()
                
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.items) { item in
                                Button(action: {
                                    viewModel.toggleSelection(for: item.id)
                                    
                                    if item.id == "Other" {
                                        withAnimation {
                                            otherSelected.toggle()
                                        }
                                    }
                                }) {
                                    VStack {
                                        Image(item.isSelected ? item.selected : item.unselected)
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .aspectRatio(contentMode: .fit)
                                        Component.DefaultText(text: item.id)
                                            .foregroundColor(item.isSelected ? .white : .black)
                                    }
                                    .frame(width: 100, height: 100)
                                    .padding(4)
                                    .background(
                                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                                            .foregroundColor(item.isSelected ? .primary1 : .white)
                                    )
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        TextField("Ketik di sini", text: $other, axis: .vertical)
                            .padding()
                            .lineLimit(5, reservesSpace: true)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(.primary1, lineWidth: 1).fill(.white))
                            .padding()
                            .opacity(otherSelected ? 1 : 0)
                            .onSubmit {
                                withAnimation {
                                    viewModel.insertNewIrritant(other)
                                    other = ""
                                }
                            }
                    }
                }
                .padding()
                
            }
            
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Pilih Pemicu Asma")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: (viewModel.triggers.isEmpty) ? "Lewati" : "Simpan") {
                        viewModel.printTriggers()
                        router.path.append(Page.TabBar)
                    }
                }
                
//                ToolbarItem(placement: .topBarLeading) {
//                    Button {
//                        router.path.removeLast()
//                    } label: {
//                        Image(systemName: "chevron.backward")
//                            .resizable()
//                            .foregroundColor(.black)
//                            .padding(.leading)
//                    }
//                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    IrritantsView()
        .environmentObject(Router())
}
