//
//  CalendarDetailViewModel.swift
//  Poof
//
//  Created by Angela Christabel on 09/11/23.
//

import Foundation

class CalendarSheetViewModel: ObservableObject {
    @Published private(set) var time: String
    @Published private(set) var totalPuff: Int
    @Published private(set) var scale: String
    
    private let kambuh: Kambuh?
    
    init(
        time: String = "",
        totalPuff: Int = 0,
        scale: String = "",
        kambuh: Kambuh?
    ) {
        self.time = time
        self.totalPuff = totalPuff
        self.scale = scale
        self.kambuh = kambuh
    }
    
    func getData() {
        guard let kambuh = self.kambuh else { return }
        
        self.time = DateFormatUtil.shared.dateToString(date: kambuh.start, to: "HH.mm")
        self.totalPuff = kambuh.totalPuff
        self.scale = (kambuh.scale == nil) ? "No data recorded" : "\(kambuh.scale!) point(s) of breathing difficulty"
    }
}
