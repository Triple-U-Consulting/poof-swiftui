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
    @Published var processedKambuhData: [Date: [Kambuh]] = [:]
    @Published var scale: [Int] = []
    @Published var trigger: [Bool] = []
    @Published var kambuhId: [Int] = []
    @Published var showScale: [Bool] = []
    
    //@Published private(set) var error: String = ""

    private(set) var calendar = Calendar.current
    
    // MARK: Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: USE CASE
    private let getKambuhDataByDate: GetKambuhDataByDateUseCase
    private let updateConditionKambuh: UpdateKambuhConditionUseCase
    private let getKambuhDataIfScaleOrTriggerIsNull: GetKambuhDataIfScaleAndTriggerIsNullUseCase
    
    init(
        getKambuhDataByDate: GetKambuhDataByDateUseCase = GetKambuhDataByDateImpl.shared,
        getKambuhDataIfScaleOrTriggerIsNull: GetKambuhDataIfScaleAndTriggerIsNullUseCase = GetKambuhDataIfScaleAndTriggerIsNullImpl.shared,
        updateConditionKambuh: UpdateKambuhConditionUseCase = UpdateKambuhConditionImpl.shared
    ){
        self.getKambuhDataByDate = getKambuhDataByDate
        self.updateConditionKambuh = updateConditionKambuh
        self.getKambuhDataIfScaleOrTriggerIsNull = getKambuhDataIfScaleOrTriggerIsNull
    }
    
}

extension ConditionViewModel {
    func getDateKeys() -> [Date] {
        let s = self.processedKambuhData.keys.sorted{ $0 < $1 }
        print(s)
        return s
    }
    
    func getKambuhByDate(date: Date) -> [Kambuh] {
        return self.processedKambuhData[date] ?? []
    }
    
    func hasDataToBeFilled() -> Bool {
        guard !processedKambuhData.isEmpty else { return false }
        
        let data = processedKambuhData.values.flatMap{ $0 }
        
        for d in data {
            if !d.hasNotes() {
                return true
            }
        }
        return false
    }

    func fetchKambuhDataIfScaleAndTriggerIsNull(){
        Task{
            await getKambuhDataIfScaleOrTriggerIsNull.execute()
                .sink { completion in
                    switch completion{
                    case .finished:
//                        print(completion)
                        break
                    case .failure(let failure):
                        print(failure)
                        break
                    }
                } receiveValue: { kambuhResults in
                    
                    let groupedKambuhData = Dictionary(grouping: kambuhResults) { kambuh in
                        self.calendar.startOfDay(for: kambuh.start)
                    }
                    print(groupedKambuhData)
                    DispatchQueue.main.async {
                        self.processedKambuhData = groupedKambuhData
                        self.showScale = Array(repeating: false, count: groupedKambuhData.count)
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    func updateKambuhData() {
        print(self.processedKambuhData)
        Task {
            await updateConditionKambuh.execute(kambuh: self.processedKambuhData.values.flatMap{ $0 })
                .sink { completion in
                    switch completion{
                    case .finished:
//                        print(completion)
                        break
                    case .failure(let failure):
                        print(failure.localizedDescription)
                        break
                    }
                } receiveValue: { result in
                    print(result)
                }
                .store(in: &cancellables)
        }
    }
    
}
