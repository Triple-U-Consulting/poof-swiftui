//
//  ConditionViewModel.swift
//  Poof
//
//  Created by Geraldy Kumara on 02/11/23.
//

import Foundation
import Combine

class ConditionViewModel: ObservableObject {
    
    // MARK: Attributes
    @Published private(set) var message: String = ""
    @Published private(set) var kambuhList: [Kambuh] = []
    @Published var scale: [Int] = []
    @Published var trigger: [Bool] = []
    @Published var kambuhId: [Int] = []
    //@Published private(set) var error: String = ""
    
    // MARK: Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: USE CASE
    private let getKambuhDataByDate: GetKambuhDataByDateUseCase
    private let updateConditionKambuh: UpdateKambuhConditionUseCase
    
    init(
        getKambuhDataByDate: GetKambuhDataByDateUseCase = GetKambuhDataByDateImpl.shared,
        updateConditionKambuh: UpdateKambuhConditionUseCase = UpdateKambuhConditionImpl.shared
    ){
        self.getKambuhDataByDate = getKambuhDataByDate
        self.updateConditionKambuh = updateConditionKambuh
    }
    
}

extension ConditionViewModel {
    // fetch kambuh by date
    func fetchKambuhDataByDate(date: Date){
        Task{
            await getKambuhDataByDate.execute(requestDate: date)
                .sink { completion in
                    switch completion{
                    case .finished:
                        print(completion)
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { kambuhResults in
//                    guard let self = self else { return }
                    self.kambuhList = kambuhResults
                    
                    var tempScale: [Int] = []
                    var tempTrigger: [Bool] = []
                    var tempKambuhId: [Int] = []
                    
                    for kambuh in kambuhResults {
                        tempScale.append(kambuh.scale ?? 0)
                        tempTrigger.append(kambuh.trigger ?? true)
                        tempKambuhId.append(kambuh.id)
                    }
                    
                    self.scale = tempScale
                    self.trigger = tempTrigger
                    self.kambuhId = tempKambuhId
//                    print(self.kambuhList ?? "error")
                }
                .store(in: &cancellables)
        }
    }
    
    func updateKambuhData(scale: [Int], trigger: [Bool]){
        Task{
            await updateConditionKambuh.execute(kambuh_id: kambuhId, scale: scale, trigger: trigger)
                .sink { completion in
                    switch completion{
                    case .finished:
                        print(completion)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                } receiveValue: { result in
                    print(result)
                }
                .store(in: &cancellables)
        }
    }
    
}
