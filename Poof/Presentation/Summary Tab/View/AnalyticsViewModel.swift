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
    @Published private(set) var analytics: [Analytics] = []
    @Published var isLoading = false
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let getAnalytics: GetAnalyticsUseCase
    
    init(getAnalytics: GetAnalyticsUseCase = GetAnalyticsUseCaseImpl.shared) {
        self.getAnalytics = getAnalytics
    }
        
    func getAnalytics(start_date: Date, end_date: Date, frequency: String) {
        self.isLoading = true
        
        Task {
            await getAnalytics.execute(start_date: start_date, end_date: end_date, frequency: frequency)
                .sink { [weak self] completion in
                    self?.isLoading = false
                    switch completion {
                    case .finished:
                        print(completion)
                        break
                    case .failure(let failure):
                       print(failure)
                    }
                } receiveValue: { result in
                    print(result)
                }
                .store(in: &cancellables)
        }
        
    }
}
