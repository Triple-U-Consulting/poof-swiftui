//
//  PDFViewModel.swift
//  Poof
//
//  Created by Geraldy Kumara on 16/11/23.
//

import Foundation
import SwiftUI
import Combine

class PdfViewModel: ObservableObject {
    
    @Published var pdfContent = PdfContent()
    @Published var pdfChartModel: [PdfChartModel] = PdfChartModel.dataPdf
    @Published var analytics: [Analytics] = []
    @Published var start_date: Date = Date()
    
    // MARK: Cancellable
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: UseCase
//    private let getQuarterAnalytics: GetQuarterAnalyticsUseCase
    
//    init(
//        getQuarterAnalytics: GetQuarterAnalyticsUseCase = GetQuarterAnalyticsImpl.shared
//    ) {
//        self.getQuarterAnalytics = getQuarterAnalytics
//    }
    
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
    
//    func getQuarterAnalytics(start_date: Date) {
//        Task {
//            await getQuarterAnalytics.execute(start_date: start_date)
//                .sink {completion in
//                    switch completion {
//                    case .finished:
//                        print(completion)
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                } receiveValue: { result in
//                    self.analytics = result
//                    print(result)
//                }
//                .store(in: &cancellables)
//        }
//    }
    
    func getFromQuarterDate(date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -90, to: date)!
    }
    
}
