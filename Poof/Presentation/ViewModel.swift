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
    private let getInhalerId: PairInhalerUsecase
//    private let updateUserInhaler: UpdateUserInhalerUsecase
    private let login: LoginUserUsecase
    
    private let stateManager: StateManager
    private let userDefaultsController: UserDefaultsController
    
    init(
        getKambuh: GetKambuhDataUseCase = GetKambuhDataImpl.shared,
        getKambuhById: GetKambuhDataByIdUseCase = GetKambuhDataByIdImpl.shared,
        getInhalerId: PairInhalerUsecase = PairInhalerImpl.shared,
//        updateUserInhaler: UpdateUserInhalerUsecase = UpdateUserInhalerImpl.shared,
        login: LoginUserUsecase = LoginUserImpl.shared,
        stateManager: StateManager = StateManager.shared,
        userDefaultsController: UserDefaultsController = UserDefaultsControllerImpl.shared
    ) {
//        self.name = name
        self.getKambuh = getKambuh
        self.getKambuhById = getKambuhById
        self.getInhalerId = getInhalerId
//        self.updateUserInhaler = updateUserInhaler
        self.login = login
        self.stateManager = stateManager
        self.userDefaultsController = userDefaultsController
        
//        stateManager.inhalerId.publisher
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let _):
//                    break
//                }
//            } receiveValue: { inhalerId in
//                Task {
//                    await self.updateUserInhaler.execute(requestValue: inhalerId, userToken: userDefaultsController.getString(key: "token")!)
//                }
//            }
//            .store(in: &cancellables)

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
            await getInhalerId.execute()
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
    
    func loginUser(email: String, password: String) {
        Task {
            await login.execute(email: email, password: password)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { accessToken in
                    if let accessToken = accessToken {
                        self.userDefaultsController.save(accessToken, asKey: "token")
                    }
                }
        }
    }
}
