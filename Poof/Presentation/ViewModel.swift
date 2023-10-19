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

class ViewModel: ObservableObject {
    // MARK: - Attributes
//    @Published var name: String
    @Published private(set) var kambuhList: [Kambuh] = []
    @Published private(set) var status: LoadingStatus = .initial
    @Published private(set) var inhalerStatus: InhalerStatus = .initial
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let getKambuh: GetKambuhDataUseCase
    private let getKambuhById: GetKambuhDataByIdUseCase
    private let registerInhaler: RegisterInhalerUsecase
//    private let addWifi: AddWifiUseCase
    
    init(
        getKambuh: GetKambuhDataUseCase = GetKambuhDataImpl.shared,
        getKambuhById: GetKambuhDataByIdUseCase = GetKambuhDataByIdImpl.shared,
        registerInhaler: RegisterInhalerUsecase = RegisterInhalerImpl.shared
//        addWifi: AddWifiUseCase = AddWifiImpl.shared
    ) {
//        self.name = name
        self.getKambuh = getKambuh
        self.getKambuhById = getKambuhById
        self.registerInhaler = registerInhaler
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
    
    func findInhaler() {
        Task {
            await registerInhaler.execute()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
//                        self?.status = .success
                    case .failure(let failure):
                        print(failure)
//                        self?.status = .failure(failure: failure)
                    }
                } receiveValue: { _ in
                    //
                }
                .store(in: &cancellables)
        }
    }
}
