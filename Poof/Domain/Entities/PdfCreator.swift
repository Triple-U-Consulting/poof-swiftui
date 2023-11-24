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
    
    private func addImage(image: UIImage, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let imageRect = CGRect(x: x, y: y, width: width, height: height)
        image.draw(in: imageRect)
    }
    
    //    private func addChartPdf() {
    //        let pdfView = ChartPdfView().environmentObject(PdfViewModel())
    ////        print(view)
    //        let size = CGSize(width: 800, height: 372)
    //        let hostingController = UIHostingController(rootView: pdfView)
    //        let view = hostingController.view
    //
    //        print(view?.subviews as Any)
    //
    //        // Set the size directly when creating the hosting controller
    //        view?.bounds = CGRect(origin: CGPoint(x: 59, y: 0), size: size)
    //        view?.backgroundColor = .clear
    //
    //        // render image
    //        let renderer = UIGraphicsImageRenderer(size: size)
    //
    //        let image = renderer.image { _ in
    //            view?.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
    //        }
    //
    //        let halfSize = CGSize(width: image.size.width * 0.7, height: image.size.height * 0.7)
    //        let halfScale = UIScreen.main.scale * 0.7
    //        let scaledImage = UIImage(cgImage: image.cgImage!, scale: halfScale, orientation: image.imageOrientation).scaled(to: halfSize)
    //
    //        let imageRect = CGRect(origin: CGPoint(x: 0, y: 200), size: halfSize)
    //
    //
    //        if let data = image.pngData() {
    //            let filename = getDocumentsDirectory().appendingPathComponent("hasilRender3.png")
    //            try? data.write(to: filename)
    //        }
    //        scaledImage.draw(in: imageRect)
    //    }
    //
    //
    //    func getDocumentsDirectory() -> URL {
    //        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //        return paths[0]
    //    }
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
                addImage(image: UIImage(named: "ChartPdfView")!, x: 39, y: 161, width: 518, height: 259)
                addImage(image: UIImage(named: "ChartForegroundStyle")!, x: 212, y: 436, width: 170, height: 14)
                addImage(image: UIImage(named: "SummaryChart")!, x: 39, y: 459, width: 518, height: 52)
                addImage(image: UIImage(named: "TimeUsage")!, x: 39, y: 553, width: 214, height: 115)
                addImage(image: UIImage(named: "ScalePdf")!, x: 269, y: 553, width: 291, height: 115)
                addImage(image: UIImage(named: "TriggerPdf")!, x: 39, y: 716, width: 518, height: 52)
            }
            return data
        }
        return nil
    }
}
