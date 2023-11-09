//
//  CalendarSheetView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 06/11/23.
//

import SwiftUI

struct CalendarSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: CalendarViewModel

    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, spacing:0){
                Component.DefaultText(text: "Tracked on 20 October 2023")
                    .padding(.bottom, 24)
                if true {
                    ForEach(1...2, id:\.self) {index in
                        CalendarSheetDetailView()
                    }
                } else {
                    Component.DefaultText(text: "No inhaler usage tracked")
                        .font(.systemButtonText)
                }
            }
        }
        .frame(width: .infinity)
        .padding(26)
        .ignoresSafeArea()
        .presentationDetents([.height(500), .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    CalendarSheetView()
        .environmentObject(CalendarViewModel())
}


struct CalendarSheetDetailView: View {
    var body: some View {
        VStack (spacing:0) {
            HStack (spacing:0) {
                Text(Image(systemName: "clock"))
                    .font(.systemHeadline)
                    .foregroundColor(.primary1)
                Component.DefaultText(text: " 9.56")
                    .font(.systemHeadline)
                    .foregroundColor(.black)
                Spacer()
                Component.DefaultText(text: "Edit")
                    .font(.systemHeadline)
                    .foregroundColor(.primary1)
                    .onTapGesture {
                        //logic
                    }
            }
            HStack (alignment: .top, spacing:0) {
                VStack (alignment: .leading, spacing:0) {
                    Component.DefaultText(text: "Inhaler Usage")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "2 Inhaler Puff")
                        .padding(.top, 8)
                    
                    Component.DefaultText(text: "Breathing Difficulty Scale")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "4 Points of Breathing Difficulty")
                        .padding(.top, 8)
                    
                    Component.DefaultText(text: "Triggered By")
                        .font(.systemHeadline)
                        .foregroundColor(.primary1)
                        .padding(.top, 12)
                    Component.DefaultText(text: "XXX")
                        .padding(.top, 8)
                        .padding(.bottom, 12)
                }.padding(.leading, 12)
                
                Spacer()
                
            }
            .frame(width: 338)
            .background(.gray6)
            .cornerRadius(10)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
    }
}
