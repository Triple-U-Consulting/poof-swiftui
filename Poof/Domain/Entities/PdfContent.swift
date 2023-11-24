//
//  PdfContent.swift
//  Poof
//
//  Created by Geraldy Kumara on 20/11/23.
//

import Foundation

struct PdfContent{
    var title: String = ""
    var body: String = ""
}

struct PdfChartModel: Identifiable {
    let id = UUID()
    let week: String
    let totalPuff: Int?
}

extension PdfChartModel {
    
    static let dataPdf: [PdfChartModel] = [
        PdfChartModel(week: "Week 1", totalPuff: 3),
        PdfChartModel(week: "Week 2", totalPuff: 2),
        PdfChartModel(week: "Week 3", totalPuff: 1),
        PdfChartModel(week: "Week 4", totalPuff: 7),
        PdfChartModel(week: "Week 5", totalPuff: nil),
        PdfChartModel(week: "Week 6", totalPuff: 4),
        PdfChartModel(week: "Week 7", totalPuff: 5),
        PdfChartModel(week: "Week 8", totalPuff: 4)
    ]
    
}
