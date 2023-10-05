//
//  ViewModel.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var name: String
    
    init(name: String) {
        self.name = name
    }
}
