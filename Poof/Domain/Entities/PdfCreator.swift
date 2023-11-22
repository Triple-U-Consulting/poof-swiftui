//
//  PdfCreator.swift
//  Poof
//
//  Created by Geraldy Kumara on 19/11/23.
//

import Foundation
import SwiftUI
import UIKit

class PdfCreator: NSObject {
    
    private let pageRect: CGRect
    private let renderer: UIGraphicsPDFRenderer?
    
    // Create layout and information about pdf
    init(
        pageRect: CGRect = CGRect(x: 0, y: 0, width: 595, height: 842)
    ) {
        let format = UIGraphicsPDFRendererFormat()
        let metadata = [
            kCGPDFContextTitle: "Report Airopuff",
            kCGPDFContextAuthor: "Airopuff"
        ]
        
        format.documentInfo = metadata as [String: Any]
        
        self.pageRect = pageRect
        self.renderer = UIGraphicsPDFRenderer(bounds: self.pageRect, format: format)
        
        super.init()
    }
}

// Draw the content
extension PdfCreator {
    
    private func addImage(image: UIImage, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let imageRect = CGRect(x: x, y: y, width: width, height: height)
        image.draw(in: imageRect)
    }
    
    private func addTitle(title: String, x: CGFloat, y: CGFloat, paddingVertical: CGFloat = 0, paddingHorizontal: CGFloat = 0, fontSize: CGFloat) {
        let paddingX: CGFloat = paddingVertical
        let paddingY: CGFloat = paddingHorizontal
        let textRect = CGRect(x: x + paddingX, y: y + paddingY, width: pageRect.width - 40, height: 40)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: fontSize)
        ]
        
        title.draw(in: textRect, withAttributes: attributes)
    }
    
    private func addSubTitle(title: String, x: CGFloat, y: CGFloat, paddingVertical: CGFloat = 0, paddingHorizontal: CGFloat = 0, fontSize: CGFloat) {
        let paddingX: CGFloat = paddingVertical
        let paddingY: CGFloat = paddingHorizontal
        let textRect = CGRect(x: x + paddingX, y: y + paddingY, width: pageRect.width - 40, height: 40)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        ]
        
        title.draw(in: textRect, withAttributes: attributes)
    }
    
    private func addBody(body: String,  x: CGFloat, y: CGFloat, paddingVertical: CGFloat = 0, paddingHorizontal: CGFloat = 0, fontSize: CGFloat){
        
        let paddingX: CGFloat = paddingVertical
        let paddingY: CGFloat = paddingHorizontal
        let bodyRect = CGRect(x: x + paddingX, y: y + paddingY, width: pageRect.width - 40, height: pageRect.height - 80)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.black,
        ]
        
        body.draw(in: bodyRect, withAttributes: attributes)
    }
    
    private func addBlueTitle(title: String, x: CGFloat, y: CGFloat, paddingVertical: CGFloat = 0, paddingHorizontal: CGFloat = 0) {
        let paddingX: CGFloat = paddingVertical
        let paddingY: CGFloat = paddingHorizontal
        let textRect = CGRect(x: x + paddingX, y: y + paddingY, width: pageRect.width - 40, height: 40)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            .foregroundColor: UIColor.UIMain.blueTitlePdf
        ]
        
        title.draw(in: textRect, withAttributes: attributes)
    }

    private func addDivider(image: UIImage, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let imageRect = CGRect(x: x, y: y, width: width, height: height)
        image.draw(in: imageRect)
    }
    
    private func addSummary(text: String, x: CGFloat, y: CGFloat, paddingVertical: CGFloat = 0, paddingHorizontal: CGFloat = 0) {
        let paddingX: CGFloat = paddingVertical
        let paddingY: CGFloat = paddingHorizontal
        let summaryRect = CGRect(x: x + paddingX, y: y + paddingY, width: 517, height: 48)
        
        let attribute: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.UIMain.blueTitlePdf
        ]
        
        text.draw(in: summaryRect, withAttributes: attribute)
    }
    
    private func addChartPdf(view: some View, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Render the SwiftUI view to an image
        let renderer = UIGraphicsImageRenderer(bounds: hostingController.view.bounds)
        let image = renderer.image { _ in
            hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
        }
        
        // Draw the rendered image in the PDF context
        let imageRect = CGRect(x: x, y: y, width: width, height: height)
        image.draw(in: imageRect)
    }
    
}

// Show the data
extension PdfCreator {
    func createPdfData(title: String, body: String) -> Data? {
        if let renderer = self.renderer {
            let data = renderer.pdfData { context in
                context.beginPage()
                addImage(image: UIImage(named: "PdfLogo")!, x: 26.22, y: 17.71, width: 81, height: 81)
                addTitle(title: "Laporan", x: 90.85, y: 24.75, paddingVertical: 20, fontSize: 25)
                addSubTitle(title: "Laporan Bulanan Inhaler", x: 90.85, y: 64, paddingVertical: 20, fontSize: 20)
                addBlueTitle(title: "Berdasarkan 3 Bulan Pemakaian", x: 39, y: 130)
                addDivider(image: UIImage(named: "Divider")!, x: 24, y: 110, width: 540, height: 1)
                addBody(body: "© 2023 Airopuff. All rights reserved.", x: 19, y: 794, fontSize: 6)
                addBody(body: "This medical report is confidential and intended solely for the use of the individual or entity to whom it is addressed. Any unauthorized review, use, disclosure, or distribution is prohibited. If you are not the intended recipient, please contact the sender immediately and destroy all copies of the original report.", x: 22, y: 808, fontSize: 6)
                addBlueTitle(title: "Berdasarkan Waktu", x: 39, y: 517)
                addBlueTitle(title: "Skala Sesak", x: 266, y: 517)
                addBlueTitle(title: "Pemicu", x: 39, y: 683)
                addImage(image: UIImage(named: "usageIncrease")!, x: 120, y: 370, width: 10, height: 10)
                addImage(image: UIImage(named: "usageDecrease")!, x: 202, y: 370, width: 10, height: 10)
                addSubTitle(title: "Kenaikan", x: 132, y: 270, fontSize: 10)
                addSubTitle(title: "Penurunan", x: 350, y: 270,  fontSize: 10)
                let testView = Text("Hello, world")
                addChartPdf(view: testView, x: 90, y: 250, width: 200, height: 40)
            }
            return data
        }
        return nil
    }
}
