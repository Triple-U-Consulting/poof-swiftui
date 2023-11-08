////
////  EditConditionView.swift
////  Poof
////
////  Created by Geraldy Kumara on 08/11/23.
////
//
//import SwiftUI
//
//struct EditConditionView: View {
//    
//    @EnvironmentObject var vm: ConditionViewModel
//    @EnvironmentObject var router: Router
//    @State private var date: Date = Date()
//    
//    var body: some View {
//        ZStack{
//            Color(.white).ignoresSafeArea()
//            NavigationView{
//                ZStack{
//                    Color(.white).ignoresSafeArea()
//                    ScrollView{
//                        LazyVStack (alignment: .leading) {
//                            
//                            Text(("\(NSLocalizedString("Dilacak pada", comment: "")) \(DateFormatUtil.shared.dateToString(date: date, to:  "dd MMMM yyyy"))"))
//                                .padding(.bottom, 32)
//                            
////                            ForEach(vm.kambuhList.indices, id: \.self) { idx in
////                                HStack {
////                                    HStack{
////                                        Image(systemName: "clock").foregroundColor(Color.Main.blueTextSecondary)
////
////                                        Text("\(DateFormatUtil.shared.dateToString(date: vm.kambuhList[idx].start, to: "HH.mm"))")
////                                            .padding(.leading, -3)
////
////                                    }
////
//                                    Spacer()
//                                    
//                                    
//                                }
//                                
//                            }
//                        }
//                    }
//                }
//                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
//            }
//        }
////    }
////}
//
//#Preview {
//    EditConditionView()
//        .environmentObject(Router())
//        .environmentObject(ConditionViewModel())
//}
