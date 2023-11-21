//
//  IrritantsViewModel.swift
//  Poof
//
//  Created by Angelica Patricia on 21/11/23.
//

import Foundation

struct IrritansModel: Identifiable {
    let id = UUID()
    let unselected: String
    let selected: String
    var isSelected = false
}

class IrritantsViewModel: ObservableObject {
    @Published var items: [IrritansModel]
    @Published var triggers: [String] = []
    
    init() {
        items = [
            IrritansModel(unselected: "pollen-unselect", selected: "pollen-select", isSelected: false),
            IrritansModel(unselected: "exercise-unselect", selected: "exercise-select", isSelected: false),
            IrritansModel(unselected: "dust-unselect", selected: "dust-select", isSelected: false),
            IrritansModel(unselected: "stress-unselect", selected: "stress-select", isSelected: false),
            IrritansModel(unselected: "cold-unselect", selected: "cold-select", isSelected: false),
            IrritansModel(unselected: "scents-unselect", selected: "scents-select", isSelected: false),
            IrritansModel(unselected: "aqi-unselect", selected: "aqi-select", isSelected: false),
            IrritansModel(unselected: "pet-unselect", selected: "pet-select", isSelected: false),
            IrritansModel(unselected: "other-unselect", selected: "other-select", isSelected: false),
        ]
    }
    
    func toggleSelection(for itemID: UUID) {
        if let index = items.firstIndex(where: { $0.id == itemID }) {
            items[index].isSelected.toggle()
            let item = items[index]
            
            if item.isSelected {
                triggers.append(item.selected)
            } else {
                triggers.removeAll(where: { $0 == item.selected })
            }
        }
    }
    
    func printTriggers() {
        for trigger in triggers {
            print(trigger)
        }
    }
}
