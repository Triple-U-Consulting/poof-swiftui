////
////  Usage.swift
////  Poof
////
////  Created by Angelica Patricia on 04/11/23.
////
//
//import Foundation
//import SwiftUI
//import Charts
//
//enum Session: String {
//    case daytime
//    case night
//}
//
//struct Usage: Identifiable {
//    var id = UUID()
//    var date: String
//    var session: Session
//    var count: Int
//}
//
//var UsageData: [Usage] = [
//    .init(date: "2023/11/03", session: .daytime, count: 8),
//    .init(date: "2023/11/03", session: .night, count: 5),
//    .init(date: "2023/11/04", session: .daytime, count: 5),
//    .init(date: "2023/11/05", session: .daytime, count: 12),
//    .init(date: "2023/11/05", session: .night, count: 5),
//    .init(date: "2023/11/06", session: .daytime, count: 2),
//    .init(date: "2023/11/06", session: .night, count: 8)
//]
//
//struct ToyShape: Identifiable {
//    var id = UUID()
//    var color: String
//    var type: String
//    var count: Double
//}
//
//var stackedBarData: [ToyShape] = [
//    .init(color: "Green", type: "Cube", count: 2),
//    .init(color: "Green", type: "Sphere", count: 0),
//    .init(color: "Green", type: "Pyramid", count: 1),
//    .init(color: "Purple", type: "Cube", count: 1),
//    .init(color: "Purple", type: "Sphere", count: 1),
//    .init(color: "Purple", type: "Pyramid", count: 1),
//    .init(color: "Pink", type: "Cube", count: 1),
//    .init(color: "Pink", type: "Sphere", count: 2),
//    .init(color: "Pink", type: "Pyramid", count: 0),
//    .init(color: "Yellow", type: "Cube", count: 1),
//    .init(color: "Yellow", type: "Sphere", count: 1),
//    .init(color: "Yellow", type: "Pyramid", count: 2)
//]
