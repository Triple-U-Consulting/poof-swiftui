//
//  DefaultKambuhRepository.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation
import Combine

protocol KambuhRepository {
    func fetchKambuhList() async -> AnyPublisher<[Kambuh], Failure>
    func fetchKambuhById(id: Int) async -> AnyPublisher<Kambuh?, Failure>
}
