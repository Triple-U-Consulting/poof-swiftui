//
//  WifiDetailsViewModel.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import Foundation
import Combine

enum PostingStatus {
    case initial
    case loading
    case success
    case failure(failure: Failure)
}

class WiFiDetailsViewModel: ObservableObject {
    // MARK: - Attributes
    @Published private(set) var message: String? = nil
    @Published private(set) var error: String? = nil
    @Published private(set) var status: PostingStatus = .initial
    
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
        Task {
            await postWiFiDetails.execute(ssid: ssid, password: password)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.status = .success
                    case .failure(let failure):
                        self?.status = .failure(failure: failure)
                        self?.error = failure.localizedDescription
                    }
                } receiveValue: { message in
                    self.message = message
                }
                .store(in: &cancellables)
        }
    }

}
