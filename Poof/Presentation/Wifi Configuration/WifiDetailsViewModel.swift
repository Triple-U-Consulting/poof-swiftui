//
//  WifiDetailsViewModel.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import Foundation
import Combine

enum WiFiDetailsPopUpStatus {
    case initial
    case loading
    case success
    case failure
}


class WiFiDetailsViewModel: ObservableObject {
    // MARK: - Attributes
    @Published var message: String? = nil
    @Published var error: String? = nil
    @Published var popUpStatus: WiFiDetailsPopUpStatus = .initial
    @Published var isPopUpDisplayed = false
    
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let postWiFiDetails: PostWiFiDetailsUseCase
    
    init(postWiFiDetails: PostWiFiDetailsUseCase = PostWiFiDetailsUseCaseImpl.shared)
    {
        self.postWiFiDetails = postWiFiDetails
    }
    
    func postWiFiDetails(ssid: String, password: String) {
        self.popUpStatus = .loading
        self.isPopUpDisplayed = true
        Task {
                await postWiFiDetails.execute(ssid: ssid, password: password)
                    .sink { [weak self] completion in
                        switch completion {
                        case .finished:
                            if self?.message != nil {
                                self?.popUpStatus = .success
                            } else {
                                self?.popUpStatus = .failure
                            }
                        case .failure(let failure):
                            self?.popUpStatus = .failure
                            self?.error = failure.localizedDescription
                        }
                    } receiveValue: { message in
                        self.message = message
                    }
                    .store(in: &cancellables)
            }
    }
    
}
