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
    func fetchKambuhByDate(date: Date) async -> AnyPublisher<[Kambuh], Failure>
    func fetchKambuhByMonthYear(date: Date) async -> AnyPublisher<[Kambuh], Failure>
    func getKambuhIfScaleAndTriggerIsNull() async -> AnyPublisher<[Kambuh], Failure>
    func updateKambuhCondition(kambuh: [Kambuh]) async -> AnyPublisher<String, Failure>
    func addKambuh(start_time: String, total_puff: Int, scale: String, trigger: String) async -> AnyPublisher<String, Failure>
    func deleteKambuhData(kambuh_id: Int) async -> AnyPublisher<String, Failure>
}
