//
//  PDFViewModel.swift
//  Poof
//
//  Created by Geraldy Kumara on 16/11/23.
//

import Foundation
import SwiftUI

class PdfViewModel: ObservableObject {
    
    @Published var pdfContent = PdfContent()
    @Published var pdfChartModel: [PdfChartModel] = PdfChartModel.dataPdf
    
    var title: String {
        get { pdfContent.title }
        set (newTitle) {
            pdfContent.title = newTitle
        }
    }
    
    var body: String {
        get { pdfContent.body }
        set (newBody) {
            pdfContent.body = newBody
        }
    }
    
}

extension PdfViewModel {
    func showPdfData() -> Data? {
        return PdfCreator().createPdfData(title: "Ini title", body: "Ini body")
    }
}
