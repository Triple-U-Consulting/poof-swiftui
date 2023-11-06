//
//  InhalerViewModel.swift
//  Poof
//
//  Created by Angela Christabel on 01/11/23.
//

import Foundation

final class InhalerTabViewModel: ObservableObject {
    @Published private(set) var todayPuff: Int?
    @Published private(set) var weekAvgPuff: Double?
    @Published private(set) var remaining: Int?
    @Published private(set) var syncDate: String = ""
    
    
    // MARK: - Usecases
    private let getHomeData: GetHomeDataUsecase
    
    // MARK: - Utils
    private let dateFormat: DateFormatUtil
    
    init(
        getHomeData: GetHomeDataUsecase = GetHomeDataImpl.shared,
        dateFormat: DateFormatUtil = DateFormatUtil.shared
    ) {
        self.getHomeData = getHomeData
        self.dateFormat = dateFormat
    }
    
    func getData() {
        Task {
            await getHomeData.execute()
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.syncDate = self?.dateFormat.dateToString(date: Date.now, to: "HH:mm") ?? ""
                    case .failure:
                        break
                    }
                } receiveValue: { data in
                    self.todayPuff = data.today
                    self.weekAvgPuff = data.weekAvg
                    self.remaining = data.remaining
                }
        }
    }
}
