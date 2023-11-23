//
//  CalendarAddSheetViewModel.swift
//  Poof
//
//  Created by Angelica Patricia on 23/11/23.
//

import Foundation
import Combine

enum addDataStatus {
    case initial
    case loading
    case success
    case failure
}


class CalendarAddSheetViewModel: ObservableObject {
    // MARK: - Attributes
    @Published var message: String? = nil
    @Published var error: String? = nil
    @Published var status: addDataStatus = .initial
    
    @Published var time: Date = Date()
    
    let labelSkalaSesak = [
        -2 : "Not Sure",
        -1 : "Pilih",
        0 : "Fine",
        1 : "Mild",
        2 : "Moderate",
        3 : "Severe",
        4 : "Profound"
    ]
    
    let rawLabelSkalaSesak = [
        "Not Sure" : -2,
        "Pilih" : -1,
        "Fine" : 0,
        "Mild" : 1,
        "Moderate" : 2,
        "Severe" : 3,
        "Profound" : 4
    ]
    
    // MARK: - Usecases
    private let addKambuh: AddKambuhDataUsecase
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    init(
        addKambuh: AddKambuhDataUsecase = AddKambuhDataUsecaseImpl.shared
    ) {
        self.addKambuh = addKambuh
    }
    
    func addKambuh(start_time: String, total_puff: Int, scale: String, trigger: String) {
        self.status = .loading
        print(start_time,total_puff,scale,trigger)
        Task {
            await addKambuh.execute(start_time: start_time, total_puff: total_puff, scale: scale, trigger:trigger)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.status = .success
                        print(completion)
                    case .failure(let failure):
                        self?.status = .failure
                        self?.error = failure.localizedDescription
                        print(self!.error)
                    }
                } receiveValue: { message in
                    print("add kambuh \(message)")
                    DispatchQueue.main.async {
                        self.message = message
                    }
                }
                .store(in: &cancellables)
        }
    }
}
