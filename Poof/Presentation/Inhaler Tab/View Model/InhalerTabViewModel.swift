//
//  InhalerViewModel.swift
//  Poof
//
//  Created by Angela Christabel on 01/11/23.
//

import Foundation

enum SyncStatus {
    case unsynced // have not been synced
    case syncing // loading to sync
    case synced
}

final class InhalerTabViewModel: ObservableObject {
    @Published private(set) var todayPuff: Int?
    @Published private(set) var weekAvgPuff: Double?
    @Published private(set) var remaining: Int?
    @Published private(set) var syncDate: String = ""
    @Published var syncStatus: SyncStatus = .unsynced
    
    // MARK: - Usecases
    private let getHomeData: GetHomeDataUsecase
    
    // MARK: - Utils
    private let dateFormat: DateFormatUtil
    private let userDefaultsController: UserDefaultsController
    
    init(
        getHomeData: GetHomeDataUsecase = GetHomeDataImpl.shared,
        dateFormat: DateFormatUtil = DateFormatUtil.shared,
        userDefaultsController: UserDefaultsController = UserDefaultsControllerImpl.shared
    ) {
        self.getHomeData = getHomeData
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
                        DispatchQueue.main.async { [weak self] in
                            self?.syncStatus = .synced
                            self?.syncDate = self?.dateFormat.dateToString(date: Date.now, to: "HH:mm") ?? ""
                        }
                    case .failure:
                        print(completion)
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.syncStatus = .unsynced
                        }
                        break
                    }
                } receiveValue: { data in
                    DispatchQueue.main.async {
                        self.todayPuff = data.today
                        self.weekAvgPuff = data.weekAvg
                        self.remaining = data.remaining
                    }
                }
        }
    }
}
