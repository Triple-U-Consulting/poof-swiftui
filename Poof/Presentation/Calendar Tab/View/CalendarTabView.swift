//
//  CalendarView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 07/11/23.
//

import SwiftUI
import Combine
import SwiftUIIntrospect

struct CalendarTabView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userDevice: UserDevice
    @StateObject private var vm = CalendarViewModel()
    
    @State private var currProgressDate = Date()
    @State private var showSheet = false
    @State private var recentMonth = 2 //means show 3 months
    @State var selectedDate: Date?
    @State var pickerMonth: Int = Calendar.current.component(.month, from: Date.now)
    @State var pickerYear: Int = Calendar.current.component(.year, from: Date.now)
    
    // Scrolling feature
    @State private var doneScrolled: Bool = false
    @State private var previousScrollOffset: CGFloat = 0
    @State private var screenOffset: CGFloat = 0
    @State private var collectionView: UICollectionView?
    private let minimumOffset: CGFloat = 180 // Optional
    
    private let weekDaysData: [String] = ["S", "S", "R", "K", "J", "S", "M"]
        
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                Component.NextButton(text: "\(vm.getCalendarComponentString(date: currProgressDate, format: "LLLL")) \(vm.getCalendarComponentString(date: currProgressDate, format: "yyyy"))", borderColor: .white.opacity(0)) {
                    showSheet.toggle()
                }
                .padding(.top, 8)
                
                HStack (spacing:0) {
                    ForEach(weekDaysData, id:\.self) {dayName in
                        Component.DefaultText(text: "\(dayName)")
                            .font(.systemFootnote)
                            .frame(width: 53, height: 17)
                    }
                    .frame(height: 17)
                }
                .padding(.top, 16)
                
                Component.CustomDivider(width: userDevice.usableWidth)
                
                List {
                    ForEach(vm.monthsInCalendar.indices, id:\.self) {i in
                        let month = vm.monthsInCalendar[i]
                        
                        CalendarMonthView(currProgressDate: month, selectedDate: $selectedDate)
                            .id(i)
                            .onAppear {
                                //
                            }
                    }
                }
                .introspect(.list, on: .iOS(.v13, .v14, .v15), customize: {
                    $0.scrollToRow(at: IndexPath(row: vm.monthsInCalendar.count - 1, section: 0), at: .bottom, animated: false)
                })
                .introspect(.list, on: .iOS(.v16, .v17), customize: {
                    $0.scrollToItem(at: IndexPath(row: vm.monthsInCalendar.count - 1, section: 0), at: .bottom, animated: false)
                    self.collectionView = $0
                })
                .frame(maxWidth: .infinity)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Component.NavigationTitle(text: "Calendar", fontSize: .systemTitle1)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.gray8)
        }
        .onAppear {
            print("init")
            vm.initMonthsInCalendar()
            print("done init")
            print(vm.monthsInCalendar.count)
            
//            DispatchQueue.main.async {
//                let currVisibleMonthIdx = self.collectionView?.indexPathsForVisibleItems.first?[1]
//                if let idx = currVisibleMonthIdx {
//                    if idx == vm.monthsInCalendar.count - 1 {
//                        doneScrolled = true
//                    }
//                }
//            }
        }
        .sheet(isPresented: self.$showSheet) {
            CalendarDatePickerView(pickerMonth: $pickerMonth, pickerYear: $pickerYear, currProgressDate: $currProgressDate, showSheet: $showSheet)
                .environmentObject(vm)
        }

    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    CalendarTabView()
        .environmentObject(Router())
        .environmentObject(UserDevice())
}


struct CalendarDatePickerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: CalendarViewModel
    @Binding var pickerMonth: Int
    @Binding var pickerYear: Int
    @Binding var currProgressDate: Date
    @Binding var showSheet: Bool
    
    let years = Array(1970...Calendar.current.component(.year, from: Date.now))
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        NavigationView {
            HStack {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Picker("", selection: $pickerMonth) {
                        ForEach(1...months.count, id: \.self) {
                            Text(months[$0 - 1])
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                LazyVStack(alignment: .leading, spacing: 0) {
                    Picker("", selection: $pickerYear) {
                        ForEach(years, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .padding(.horizontal, 26)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Component.TextButton(text: NSLocalizedString("Selesai", comment: ""), action: {
                        currProgressDate = vm.getDateFromMonthYear(month: pickerMonth , year: pickerYear)
                        showSheet.toggle()
                    })
                }
            }
        }
        .frame(width: .infinity)
        .ignoresSafeArea()
        .presentationDetents([.height(200), .large])
        .presentationDragIndicator(.hidden)
    }
}
