//
//  SharePdfView.swift
//  Poof
//
//  Created by Geraldy Kumara on 20/11/23.
//

import Foundation
import SwiftUI

struct SharePdfView: UIViewControllerRepresentable{
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SharePdfView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<SharePdfView>) {
        //
    }
}
