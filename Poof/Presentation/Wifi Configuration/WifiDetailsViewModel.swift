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

    
    
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let postWiFiDetails: PostWiFiDetailsUseCase
    
    init(postWiFiDetails: PostWiFiDetailsUseCase = PostWiFiDetailsUseCaseImpl.shared)
    {
        self.postWiFiDetails = postWiFiDetails
    }
    
    func postWiFiDetails(ssid: String, password: String) {
        self.status = .loading
        self.isPopUpDisplayed = true
        
        Task {
            await postWiFiDetails.execute(ssid: ssid, password: password)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        if self?.message != nil {
                            self?.status = .success
                        } else {
                            self?.status = .failure
                        }
                    case .failure(let failure):
                        self?.status = .failure
                        self?.error = failure.localizedDescription
                        
                    }
                } receiveValue: { message in
                    self.message = message
                }
                .store(in: &cancellables)
            
            if self.status == .failure {
                self.isPopUpDisplayed = false
                self.showAlert = true
            } else if self.status == .success {
                self.isPopUpDisplayed = false
            }
        }
    }
    
}
