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
    
    private(set) var inhalerId: String?
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let getKambuh: GetKambuhDataUseCase
    private let getKambuhById: GetKambuhDataByIdUseCase
    private let getInhalerId: PairInhalerUsecase
    private let updateUserInhaler: UpdateUserInhalerUsecase
    private let updateInhalerBottle: UpdateInhalerDoseUsecase
    private let login: LoginUserUsecase
    
    private let stateManager: StateManager
    private let userDefaultsController: UserDefaultsController
    
    init(
        getKambuh: GetKambuhDataUseCase = GetKambuhDataImpl.shared,
        getKambuhById: GetKambuhDataByIdUseCase = GetKambuhDataByIdImpl.shared,
        getInhalerId: PairInhalerUsecase = PairInhalerImpl.shared,
        updateUserInhaler: UpdateUserInhalerUsecase = UpdateUserInhalerImpl.shared,
        updateInhalerBottle: UpdateInhalerDoseUsecase = UpdateInhalerDoseImpl.shared,
        login: LoginUserUsecase = LoginUserImpl.shared,
//        addWifi: AddWifiUseCase = AddWifiImpl.shared
        stateManager: StateManager = StateManager.shared,
        userDefaultsController: UserDefaultsController = UserDefaultsControllerImpl.shared
    ) {
//        self.name = name
        self.getKambuh = getKambuh
        self.getKambuhById = getKambuhById
        self.getInhalerId = getInhalerId
        self.updateUserInhaler = updateUserInhaler
        self.updateInhalerBottle = updateInhalerBottle
        self.login = login
        self.stateManager = stateManager
        self.userDefaultsController = userDefaultsController
        
//        stateManager.inhalerId.publisher
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error)
//                    break
//                }
//            } receiveValue: { inhalerId in
//                self.updateUserInhalerId(id: inhalerId)
//            }
//            .store(in: &cancellables)

    }
    
    func fetchKambuh() {
//        self.status = .loading
        Task {
            await getKambuh.execute()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
//                        self?.status = .success
                    case .failure(let failure):
                        print(failure)
//                        self?.status = .failure(failure: failure)
                    }
                } receiveValue: { kambuhResults in
                    self.kambuhList = kambuhResults
                }
                .store(in: &cancellables)
        }
    }
    
    func findInhaler() {
        self.status = .loading
        Task {
            await getInhalerId.execute()
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        DispatchQueue.main.async {
                            self?.status = .success
                        }
                    case .failure(let failure):
                        print(failure)
                        DispatchQueue.main.async {
                            self?.status = .failure(failure: failure)
                        }
                    }
                } receiveValue: { inhalerId in
                    self.inhalerId = inhalerId
                }
                .store(in: &cancellables)
        }
    }
    
    func updateUserInhalerId() {
        Task {
            await self.updateUserInhaler.execute(requestValue: self.inhalerId ?? "", userToken: userDefaultsController.getString(key: "token") ?? "")
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { result in
                    print(result)
                }
        }
    }
    
    func updateDose(dose: Int = 200) {
        guard let inhalerId = self.inhalerId else { return }
        
        Task {
            await self.updateInhalerBottle.execute(inhalerId: inhalerId, dose: dose)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { result in
                    print(result)
                }
        }
    }
}
