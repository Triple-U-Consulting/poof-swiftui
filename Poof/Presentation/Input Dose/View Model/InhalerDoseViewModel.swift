//
//  InhalerDoseViewModel.swift
//  Poof
//
//  Created by Angela Christabel on 11/11/23.
//

import Foundation
import Combine

enum DoseUpdateStatus {
    case initial
    case loading
    case success
    case failure
}

class InhalerDoseViewModel: ObservableObject {
    // MARK: - Attributes
    @Published var message: String? = nil
    @Published var status: DoseUpdateStatus = .initial
    @Published var showAlert: Bool = false
    @Published var isPopUpDisplayed = false
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let updateInhalerBottle: UpdateInhalerDoseUsecase
    
    private let stateManager: StateManager
    
    init(
        updateInhalerBottle: UpdateInhalerDoseUsecase = UpdateInhalerDoseImpl.shared,
        stateManager: StateManager = StateManager.shared
    ) {
        self.updateInhalerBottle = updateInhalerBottle
        self.stateManager = stateManager
    }
    
    func updateDose(dose: Int = 200) {
        self.status = .loading
        self.isPopUpDisplayed = true
        
        guard let inhalerId = self.stateManager.inhalerId else { return }
        
        Task {
            await self.updateInhalerBottle.execute(inhalerId: inhalerId, dose: dose)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.isPopUpDisplayed = false
                        self?.status = .success
                    case .failure(let failure):
                        self?.isPopUpDisplayed = false
                        self?.status = .failure
                        self?.showAlert = true
                        print(failure)
                    }
                } receiveValue: { result in
                    DispatchQueue.main.async {
                        self.message = result
                    }
                    print(result)
                }
        }
    }
}
