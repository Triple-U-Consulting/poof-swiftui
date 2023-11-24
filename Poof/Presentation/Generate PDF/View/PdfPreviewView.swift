//
//  PDF View.swift
//  Poof
//
//  Created by Geraldy Kumara on 16/11/23.
//

import SwiftUI

struct PdfPreviewView: View {
    
    @EnvironmentObject private var vm: PdfViewModel
    @EnvironmentObject private var router: Router
    //@State private var showShareSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color(Color.white).ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    
                    Button(action: {
                        router.path.removeLast(2)
                    }, label: {
                        Text("Selesai")
                            .foregroundColor(Color.Main.blueTextSecondary)
                    })
                    .padding(.trailing, 20)
                }
                PdfViewUI(data: vm.showPdfData())
                    .environmentObject(vm)
                
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Spacer()
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    Image(systemName: "arrowshape.turn.up.backward")
                }
                .padding([.top, .bottom], 0)
                .padding([.leading, .trailing], 20)
                .foregroundColor(Color.Main.blueText)
            }
        }
    }
}

#Preview {
    PdfPreviewView()
        .environmentObject(PdfViewModel())
        .environmentObject(Router())
}
