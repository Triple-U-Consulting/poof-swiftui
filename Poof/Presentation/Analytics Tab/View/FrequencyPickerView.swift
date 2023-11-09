//
//  FrequencyPickerView.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import SwiftUI

struct FrequencyPickerView: View {
    @Binding var frequency: String

    var body: some View {
        Picker("Frequency", selection: $frequency) {
            Text("Day").tag("day")
            Text("Week").tag("week")
            Text("Month").tag("month")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

//#Preview {
//    FrequencyPickerView()
//}
