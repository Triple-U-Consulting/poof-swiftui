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
    @Published var sameDate: [Date] = []
    //@Published private(set) var error: String = ""

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
                                        
                    var tempScale: [Int] = []
                    var tempTrigger: [Bool] = []
                    var tempKambuhId: [Int] = []
                    //self.kambuhList = []
                    
                    for kambuh in kambuhResults {
                        tempScale.append(kambuh.scale ?? 0)
                        tempTrigger.append(kambuh.trigger ?? true)
                        tempKambuhId.append(kambuh.id)
                    }
                    
                    self.scale = tempScale
                    self.trigger = tempTrigger
                    self.kambuhId = tempKambuhId
                    self.kambuhList = kambuhResults
                    
//                    print(self.kambuhList ?? "error")
                }
                .store(in: &cancellables)
        }
    }
    
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
                                        
                    var tempScale: [Int] = []
                    var tempTrigger: [Bool] = []
                    var tempKambuhId: [Int] = []
                    var tempStartDate: [Date] = []
                    var tempEndDate: [Date] = []
                    var tempSameDay: [Date] = []
                    //self.kambuhList = []
                    
                    for kambuh in kambuhResults {
                        tempScale.append(kambuh.scale ?? 0)
                        tempTrigger.append(kambuh.trigger ?? true)
                        tempKambuhId.append(kambuh.id)
                        tempStartDate.append(kambuh.start)
                        tempEndDate.append(kambuh.end)
                    }
                    
                    for i in tempStartDate.indices{
                        if DateFormatUtil.shared.dateToString(date: tempStartDate[i], to:  "dd MMMM yyyy") == DateFormatUtil.shared.dateToString(date: tempEndDate[i], to:  "dd MMMM yyyy") {
                                tempSameDay += [tempStartDate[i]]
                            }
                    }
                    
                    self.scale = tempScale
                    self.trigger = tempTrigger
                    self.kambuhId = tempKambuhId
                    self.sameDate = tempSameDay
                    self.kambuhList = kambuhResults
                    print(tempSameDay)
//                    print(self.kambuhList ?? "error")
                }
                .store(in: &cancellables)
        }
    }
    
    func updateKambuhData(){
        Task {
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
