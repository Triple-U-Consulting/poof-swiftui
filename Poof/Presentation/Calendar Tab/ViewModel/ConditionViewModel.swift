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
    
    //@Published private(set) var error: String = ""

    private(set) var calendar = Calendar.current
    
    // MARK: Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: USE CASE
    private let getKambuhDataByDate: GetKambuhDataByDateUseCase
    private let updateConditionKambuh: UpdateKambuhConditionUseCase
    private let getKambuhDataIfScaleOrTriggerIsNull: GetKambuhDataIfScaleAndTriggerIsNullUseCase
    private let deleteKambuhData: DeleteKambuhDataUseCase
    
    init(
        getKambuhDataByDate: GetKambuhDataByDateUseCase = GetKambuhDataByDateImpl.shared,
        getKambuhDataIfScaleOrTriggerIsNull: GetKambuhDataIfScaleAndTriggerIsNullUseCase = GetKambuhDataIfScaleAndTriggerIsNullImpl.shared,
        updateConditionKambuh: UpdateKambuhConditionUseCase = UpdateKambuhConditionImpl.shared,
        deleteKambuhData: DeleteKambuhDataUseCase = DeleteKambuhDataImpl.shared
    ){
        self.getKambuhDataByDate = getKambuhDataByDate
        self.updateConditionKambuh = updateConditionKambuh
        self.getKambuhDataIfScaleOrTriggerIsNull = getKambuhDataIfScaleOrTriggerIsNull
        self.deleteKambuhData = deleteKambuhData
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
    
    func deleteKambuhData(key: Date, index: Int){
        let kambuh = self.processedKambuhData[key]![index]
        
        Task {
            await deleteKambuhData.execute(kambuh_id: kambuh.id)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Deletted item")
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { message in
                    print(message)
                    self.message = message
                }
                .store(in: &cancellables)
        }
    }
}
