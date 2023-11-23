//
//  IrritantsViewModel.swift
//  Poof
//
//  Created by Angelica Patricia on 21/11/23.
//

import Foundation

struct IrritantsModel: Identifiable {
    let id: String
    let unselected: String
    let selected: String
    var isSelected = false
}

class IrritantsViewModel: ObservableObject {
    @Published var items: [IrritantsModel]
    @Published var triggers: [String] = []
    
    init() {
        items = [
            IrritantsModel(id: "Pollen", unselected: "pollen-unselect", selected: "pollen-select", isSelected: false),
            IrritantsModel(id: "Exercise", unselected: "exercise-unselect", selected: "exercise-select", isSelected: false),
            IrritantsModel(id: "Dust", unselected: "dust-unselect", selected: "dust-select", isSelected: false),
            IrritantsModel(id: "Stress", unselected: "stress-unselect", selected: "stress-select", isSelected: false),
            IrritantsModel(id: "Cold", unselected: "cold-unselect", selected: "cold-select", isSelected: false),
            IrritantsModel(id: "Scents", unselected: "scents-unselect", selected: "scents-select", isSelected: false),
            IrritantsModel(id: "Aqi", unselected: "aqi-unselect", selected: "aqi-select", isSelected: false),
            IrritantsModel(id: "Pet", unselected: "pet-unselect", selected: "pet-select", isSelected: false),
            IrritantsModel(id: "Other", unselected: "other-unselect", selected: "other-select", isSelected: false),
        ]
    }
    
    func toggleSelection(for itemID: String) {
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
    
    func insertNewIrritant(_ item: String) {
        self.items.append(IrritantsModel(id: item, unselected: "other-unselect", selected: "other-select", isSelected: true))
    }
}
