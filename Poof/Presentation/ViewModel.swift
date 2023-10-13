//
//  ViewModel.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import Foundation
import Combine

enum LoadingStatus {
    case initial
    case loading
    case success
    case failure(failure: Failure)
}

class ViewModel: ObservableObject {
    // MARK: - Attributes
//    @Published var name: String
    @Published private(set) var kambuhList: [Kambuh] = []
    @Published private(set) var status: LoadingStatus = .initial
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let getKambuh: GetKambuhDataUseCase
    private let getKambuhById: GetKambuhDataByIdUseCase
    
    init(
        getKambuh: GetKambuhDataUseCase = GetKambuhDataImpl.shared,
        getKambuhById: GetKambuhDataByIdUseCase = GetKambuhDataByIdImpl.shared
    ) {
//        self.name = name
        self.getKambuh = getKambuh
        self.getKambuhById = getKambuhById
    }
    
    func fetchKambuh() {
        self.status = .loading
        Task {
            await getKambuh.execute()
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.status = .success
                    case .failure(let failure):
                        print(failure)
                        self?.status = .failure(failure: failure)
                    }
                } receiveValue: { kambuhResults in
                    self.kambuhList = kambuhResults
                }
                .store(in: &cancellables)
        }
    }
}
