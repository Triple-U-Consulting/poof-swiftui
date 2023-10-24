//
//  StateManager.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation

final class StateManager: ObservableObject {
    static let shared = StateManager()
    
    @Published var inhalerId: String?
    
    private let userDefaultsController = UserDefaultsControllerImpl.shared
}
