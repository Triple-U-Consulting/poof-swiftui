//
//  SummaryTabView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import SwiftUI

struct SummaryTabView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice

    
    var body: some View {

        CalendarView()
        
    }
}

#Preview {
    SummaryTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}

