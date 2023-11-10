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
        return s
    }
    
    func getKambuhByDate(date: Date) -> [Kambuh] {
        return self.processedKambuhData[date] ?? []
    }
    
    // fetch kambuh by date
//    func fetchKambuhDataByDate(date: Date){
//        Task{
//            await getKambuhDataByDate.execute(requestDate: date)
//                .sink { completion in
//                    switch completion{
//                    case .finished:
//                        print(completion)
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                } receiveValue: { kambuhResults in
////                    guard let self = self else { return }
//                                        
//                    var tempScale: [Int] = []
//                    var tempTrigger: [Bool] = []
//                    var tempKambuhId: [Int] = []
//                    //self.kambuhList = []
//                    
//                    for kambuh in kambuhResults {
//                        tempScale.append(kambuh.scale ?? 0)
//                        tempTrigger.append(kambuh.trigger ?? true)
//                        tempKambuhId.append(kambuh.id)
//                    }
//                    
//                    self.scale = tempScale
//                    self.trigger = tempTrigger
//                    self.kambuhId = tempKambuhId
//                    self.kambuhList = kambuhResults
//                    
////                    print(self.kambuhList ?? "error")
//                }
//                .store(in: &cancellables)
//        }
//    }
    
    func fetchKambuhDataIfScaleAndTriggerIsNull(){
        Task{
            await getKambuhDataIfScaleOrTriggerIsNull.execute()
                .sink { completion in
                    switch completion{
                    case .finished:
                        print(completion)
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { kambuhResults in
                    
                    let groupedKambuhData = Dictionary(grouping: kambuhResults) { kambuh in
                        self.calendar.startOfDay(for: kambuh.start)
                    }
                    
                    DispatchQueue.main.async {
                        self.processedKambuhData = groupedKambuhData
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
