//
//  WifiDetailsViewModel.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import Foundation
import Combine

enum WiFiDetailsStatus {
    case initial
    case loading
    case success
    case successPaired
    case failure
}


class WiFiDetailsViewModel: ObservableObject {
    // MARK: - Attributes
    @Published var message: String? = nil
    @Published var error: String? = nil
    @Published var status: WiFiDetailsStatus = .initial
    @Published var showAlert: Bool = false
    @Published var isPopUpDisplayed = false
    @Published var showErrorText: Bool = false
    
    @Published var inhalerConnectedWifi: Bool = false
    @Published var updatedUserInhaler: Bool = false

    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let postWiFiDetails: PostWiFiDetailsUseCase
    private let updateUserInhaler: UpdateUserInhalerUsecase
    private let updateInhalerBottle: UpdateInhalerDoseUsecase
    
    private let stateManager: StateManager
    private let userDefaultsController = UserDefaultsControllerImpl.shared
    
    init(
        postWiFiDetails: PostWiFiDetailsUseCase = PostWiFiDetailsUseCaseImpl.shared,
        updateUserInhaler: UpdateUserInhalerUsecase = UpdateUserInhalerImpl.shared,
        updateInhalerBottle: UpdateInhalerDoseUsecase = UpdateInhalerDoseImpl.shared,
        stateManager: StateManager = StateManager.shared,
        userDefaultsController: UserDefaultsController = UserDefaultsControllerImpl.shared
    ) {
        self.postWiFiDetails = postWiFiDetails
        self.updateUserInhaler = updateUserInhaler
        self.updateInhalerBottle = updateInhalerBottle
        self.stateManager = stateManager
        
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
//                print(inhalerId)
//                self.updateUserInhalerId()
//            }
//            .store(in: &cancellables)
        
//        stateManager.pairedUserToInhalerDB.publisher
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error)
//                    break
//                }
//            } receiveValue: { status in
//                if status == true {
//                    self.status = .success
//                }
//            }
//            .store(in: &cancellables)
    }
    
    func updateUserInhalerId() {
        self.status = .loading
        self.message = "Getting everything ready"
        self.isPopUpDisplayed = true
        
        print("inhaler_id:")
        print(stateManager.inhalerId)
        
        if let id = stateManager.inhalerId {
            Task {
                await self.updateUserInhaler.execute(requestValue: id, userToken: userDefaultsController.getString(key: "token") ?? "")
                    .sink { [weak self] completion in
                        switch completion {
                        case .finished:
                            self?.status = .success
                        case .failure(let failure):
                            self?.status = .success
                            print(failure)
                        }
                    } receiveValue: { result in
                        print(result)
                    }
                    .store(in: &cancellables)
                
                if self.status == .success {
                    self.updatedUserInhaler = true
                    self.isPopUpDisplayed = false
                } else {
                    self.isPopUpDisplayed = false
                    self.showAlert = true
                }
            }
        }
    }
    
    func postWiFiDetails(ssid: String, password: String) {
        self.status = .loading
        self.message = "Connecting to WiFi"
        self.isPopUpDisplayed = true
        
        Task {
            await postWiFiDetails.execute(ssid: ssid, password: password)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
//                        self?.status = .failure
//                        self?.error = failure.localizedDescription
                        break
                    }
                } receiveValue: { message in
                    print(message)
                    DispatchQueue.main.async {
                        self.message = message
                        
                        if message != "WiFi Failed to Connect." {
                            self.inhalerConnectedWifi = true
                        }
                        
                        if self.status == .failure {
                            self.isPopUpDisplayed = false
                            self.showAlert = true
                        } else {
                            if message != "WiFi Failed to Connect." {
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10.0, execute: {
                                    self.updateUserInhalerId()
                                })
                            } else {
                                self.isPopUpDisplayed = false
                            }
                        }
                    }
                }
                .store(in: &cancellables)
        }
    }
    
}
