//
//  PDF View.swift
//  Poof
//
//  Created by Geraldy Kumara on 16/11/23.
//

import SwiftUI

struct PdfPreviewView: View {
    
    @EnvironmentObject private var vm: PdfViewModel
    @State private var showShareSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color(Color.white).ignoresSafeArea()
            VStack{
                PdfViewUI(data: vm.showPdfData())
                    .environmentObject(vm)
                //Component.ShareButton(showShareSheet: $showShareSheet)
            }
        }
        //        .sheet(isPresented: $showShareSheet, content: {
        //            if let data = vm.showPdfData() {
        //                SharePdfView(activityItems: [data])
        //            }
        //        })
    }
}

#Preview {
    PdfPreviewView()
        .environmentObject(PdfViewModel())
}
