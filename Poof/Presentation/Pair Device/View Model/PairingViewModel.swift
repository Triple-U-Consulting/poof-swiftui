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

enum InhalerStatus {
    case initial
    case connecting
    case success
    case failure(failure: Failure)
}

class PairingViewModel: ObservableObject {
    // MARK: - Attributes
//    @Published var name: String
    @Published private(set) var kambuhList: [Kambuh] = []
    @Published private(set) var status: LoadingStatus = .initial
    @Published private(set) var inhalerStatus: InhalerStatus = .initial
    
    @Published private(set) var inhalerId: String?
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let getInhalerId: PairInhalerUsecase
    
    private let stateManager: StateManager
    
    init(
        getInhalerId: PairInhalerUsecase = PairInhalerImpl.shared,
        stateManager: StateManager = StateManager.shared
    ) {
        self.getInhalerId = getInhalerId
        self.stateManager = stateManager
    }
    
    func findInhaler() {
        self.status = .loading
        Task {
            await getInhalerId.execute()
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.status = .success
                    case .failure(let failure):
                        print(failure)
                        self?.status = .failure(failure: failure)
                    }
                } receiveValue: { inhalerId in
                    DispatchQueue.main.async {
                        print(inhalerId)
                        self.inhalerId = inhalerId
                        self.stateManager.inhalerId = inhalerId
                    }
                }
                .store(in: &cancellables)
        }
    }
}
