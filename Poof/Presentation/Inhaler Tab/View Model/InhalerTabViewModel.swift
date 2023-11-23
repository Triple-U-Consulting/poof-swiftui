//
//  InhalerViewModel.swift
//  Poof
//
//  Created by Angela Christabel on 01/11/23.
//

import Foundation
import Combine

enum SyncStatus {
    case unsynced // have not been synced
    case syncing // loading to sync
    case synced
}

final class InhalerTabViewModel: ObservableObject {
    @Published private(set) var weekAvgPuff: Double?
    @Published private(set) var syncDate: String = ""
    @Published var todayPuff: Int?
    @Published var remaining: Int?
    @Published var syncStatus: SyncStatus = .unsynced
    @Published var processedKambuhData: [Date: [Kambuh]] = [:]
    @Published var hasDataToBeFilled: Bool = false
    
    private(set) var calendar = Calendar.current
    
    // MARK: - Usecases
    private let getHomeData: GetHomeDataUsecase
    private let getKambuhDataIfScaleOrTriggerIsNull: GetKambuhDataIfScaleAndTriggerIsNullUseCase
    
    // MARK: - Utils
    private let dateFormat: DateFormatUtil
    private let userDefaultsController: UserDefaultsController
    
    // MARK: Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getHomeData: GetHomeDataUsecase = GetHomeDataImpl.shared,
        getKambuhDataIfScaleOrTriggerIsNull: GetKambuhDataIfScaleAndTriggerIsNullUseCase = GetKambuhDataIfScaleAndTriggerIsNullImpl.shared,
        dateFormat: DateFormatUtil = DateFormatUtil.shared,
        userDefaultsController: UserDefaultsController = UserDefaultsControllerImpl.shared
    ) {
        self.getHomeData = getHomeData
        self.getKambuhDataIfScaleOrTriggerIsNull = getKambuhDataIfScaleOrTriggerIsNull
        self.dateFormat = dateFormat
        self.userDefaultsController = userDefaultsController
    }
    
    func getData() {
        syncStatus = .syncing
        Task {
            await getHomeData.execute(token: self.userDefaultsController.getString(key: "token") ?? "")
                .sink { completion in
                    switch completion {
                    case .finished:
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) { [weak self] in
                            self?.syncStatus = .synced
                            self?.syncDate = self?.dateFormat.dateToString(date: Date.now, to: "HH:mm") ?? ""
                        }
                    case .failure:
                        print(completion)
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) { [weak self] in
                            self?.syncStatus = .unsynced
                        }
                        break
                    }
                } receiveValue: { data in
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
                        self.todayPuff = data.today
                        self.weekAvgPuff = data.weekAvg
                        self.remaining = data.remaining
                    }
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
                    
                    let groupedKambuhData = Dictionary(grouping: kambuhResults) { kambuh in
                        self.calendar.startOfDay(for: kambuh.start)
                    }
                    
                    DispatchQueue.main.async {
                        self.processedKambuhData = groupedKambuhData
                        if self.processedKambuhData.count > 0 {
                            self.hasDataToBeFilled = true
                        } else {
                            self.hasDataToBeFilled = false
                        }
                    }
                }
                .store(in: &cancellables)
        }
    }
}
