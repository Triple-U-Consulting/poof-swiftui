//
//  GeneratePdfView.swift
//  Poof
//
//  Created by Geraldy Kumara on 19/11/23.
//

import SwiftUI

struct GeneratePdfView: View {
    
    @EnvironmentObject private var vm: PdfViewModel
    @EnvironmentObject private var router: Router
    @State private var toDate: Date = Date()
    
    var body: some View {
        ZStack {
            Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
            NavigationView {
                ZStack (alignment: .leading) {
                    Color(Color.Neutrals.sheetBackground).ignoresSafeArea()
                    VStack (alignment: .leading) {
                        
                        Text("Generate Report")
                            .padding(.bottom, 16)
                        ZStack{
                            HStack{
                                Text("\(NSLocalizedString("Report", comment: ""))")
                                    .font(.systemBodyText)
                                
                                Text("90 days")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding()
                            .frame(height: 45)
                            .background(Color.Main.backgroundTitleReportCard)
                            .cornerRadius(10)
                        }
                        
                        
                        VStack{
                            HStack{
                                Text("\(NSLocalizedString("From", comment: ""))")
                                    .font(.systemBodyText)
                                
                                Text("\(DateFormatUtil().dateToString(date: vm.getFromQuarterDate(date: toDate), to: "dd-MM-yyyy"))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.bottom, -8)
                            
                            Component.CustomDivider(width: 330)
                            
                            HStack{
                                Text("\(NSLocalizedString("To", comment: ""))")
                                    .font(.systemBodyText)
                                
                                ZStack{
                                    Component.DatePickerTextField(placeholder: "", date: $toDate)
                                        .position(x: 362, y: 18)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(.primary1, lineWidth: 1)
                                                .frame(width: 109, height: 32)
                                                .position(x: 255, y: 18)
                                        }
                                }
                            }
                        }
                        
                        .padding()
                        .frame(width: 362, height:  97)
                        .background(.white)
                        .clipShape(.rect(
                            bottomLeadingRadius: 10,
                            bottomTrailingRadius: 10
                        ))
                        .padding(.top, -14)
                        
                        Component.DefaultButton(text: "Generate") {
                            router.path.append(Page.PdfPreview)
                        }
                        .padding(.top, 16)
                        
                        HStack{
                            Image("ExclamationMark.circle")
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            Text("Caution")
                                .font(.system(size: 16))
                        }
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 0))
                        
                        Text("For professional consultation only; do not make health decisions based on this report. Consult a licensed healthcare professional for accurate diagnosis and treatment.")
                            .font(.caption)
                            .padding(.leading, 8)
                        
                        
                        Spacer()
                    }
                    .toolbar(content: {
                        Component.TextButton(text: "Cancel", color: .red) {
                            router.path.removeLast()
                        }
                    })
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }
}

#Preview {
    GeneratePdfView()
        .environmentObject(PdfViewModel())
        .environmentObject(Router())
}
