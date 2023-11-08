//
//  AnalyticsViewModel.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation
import Combine

class AnalyticsViewModel: ObservableObject {
    // MARK: - Attributes
    @Published private(set) var message: String = ""
    @Published var selectedFrequency: Frequency = .week
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var analytics: [Analytics] = []
    @Published var currentDate: Date = Date()
    var averagePuffs: Int {
        let totalPuffs = analytics.reduce(0) { $0 + $1.daytimeUsage + $1.nightUsage }
        return !analytics.isEmpty ? Int(totalPuffs) / Int(analytics.count) : 0
    }
    var highestUsage: Int {
        analytics.max(by: { ($0.daytimeUsage + $0.nightUsage) < ($1.daytimeUsage + $1.nightUsage) })?.daytimeUsage ?? 0
    }
    
    var lowestUsage: Int {
        analytics.min(by: { ($0.daytimeUsage + $0.nightUsage) < ($1.daytimeUsage + $1.nightUsage) })?.daytimeUsage ?? 0
    }
    
    var totalDaytimeUsage: Int {
        analytics.reduce(0) { $0 + $1.daytimeUsage }
    }
    
    var totalNightUsage: Int {
        analytics.reduce(0) { $0 + $1.nightUsage }
    }
    
    var dayWithoutUsage: Int {
        analytics.filter { $0.daytimeUsage == 0 && $0.nightUsage == 0 }.count
    }
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let getAnalytics: GetAnalyticsUseCase
    
    init(getAnalytics: GetAnalyticsUseCase = GetAnalyticsUseCaseImpl.shared) {
        self.getAnalytics = getAnalytics
    }
    
    func fetchAnalytics() {
        Task {
            await getAnalytics.execute(start_date: currentDate, frequency: selectedFrequency.rawValue)
                .sink {completion in
                    switch completion {
                    case .finished:
                        print(completion)
                        break
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { result in
                    self.analytics = result
                    self.startDate = self.analytics.first?.start_date
                    self.endDate = self.analytics.last?.end_date
                    print(result)
                }
                .store(in: &cancellables)
        }
        
    }
    
    func goBackward() {
        switch selectedFrequency {
        case .week:
            currentDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) ?? currentDate
        case .month:
            currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
//        case .year:
//            currentDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate) ?? currentDate
        case .quarter:
            currentDate = Calendar.current.date(byAdding: .month, value: -3, to: currentDate) ?? currentDate
        case .halfyear:
            currentDate = Calendar.current.date(byAdding: .month, value: -6, to: currentDate) ?? currentDate

        }
        fetchAnalytics()
    }
    
    func goForward() {
        switch selectedFrequency {
        case .week:
            currentDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate) ?? currentDate
        case .month:
            currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
//        case .year:
//            currentDate = Calendar.current.date(byAdding: .year, value: 1, to: currentDate) ?? currentDate
        case .quarter:
            currentDate = Calendar.current.date(byAdding: .month, value: 3, to: currentDate) ?? currentDate
        case .halfyear:
            currentDate = Calendar.current.date(byAdding: .month, value: 6, to: currentDate) ?? currentDate
        }
        fetchAnalytics()
    }
}


