//
//  SignComponent.swift
//  Poof
//
//  Created by Geraldy Kumara on 18/10/23.
//

import Foundation
import SwiftUI
import UIKit

// MARK: Sign Component
extension Component {
    
    /// Title sign page
    struct titleSignPage: View {
        
        var text: String
        
        init(text: String){
            self.text = text
        }
        
        var body: some View {
            HStack{
                Text(NSLocalizedString(text, comment: ""))
                    .foregroundColor(.black)
                    .font(.systemHeadline)
                
                Text("*")
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 0))
        }
    }
    
    /// Bottom text
    struct bottomSignText: View {
        
        var text: String
        var blueText: String
        var action: () -> Void
        
        var body: some View {
            HStack{
                Text(NSLocalizedString(text, comment: ""))
                    .foregroundStyle(Color.Neutrals.grayBottomSignText)
                
                Button(action: action) {
                    Text(NSLocalizedString(blueText, comment: ""))
                        .foregroundStyle(Color.Main.blueText)
                }
            }
        }
    }
    
    struct textErrorMessageSignPage: View {
        var string: String
        var body: some View {
            Text((NSLocalizedString(string, comment: "")))
                .font(.systemBodyText)
                .foregroundStyle(.red)
        }
    }
    
    struct DatePickerTextField: UIViewRepresentable{
        
        private let helper = Helper()
        private let textField = UITextField()
        private let datePicker = UIDatePicker()
        private let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            return df
        }()
        
        public var placeholder: String
        @Binding public var date: Date
        
        func makeUIView(context: Context) -> UITextField {
            self.datePicker.datePickerMode = .date
            self.datePicker.preferredDatePickerStyle = .wheels
            self.datePicker.maximumDate = Date()
            self.datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
            self.textField.placeholder = self.placeholder
            self.textField.inputView = self.datePicker
            
            // Accessory View
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
            toolbar.setItems([flexibleSpace, doneButton], animated: true)
            self.textField.inputAccessoryView = toolbar
            
            self.helper.dateChanged = {
                self.date = self.datePicker.date
            }
            
            self.helper.doneButtonTapped = {
                self.date = self.datePicker.date
                self.textField.resignFirstResponder()
            }
            
            return self.textField
        }
        
        func updateUIView(_ uiView: UITextField, context: Context) {
            uiView.text = self.dateFormatter.string(from: self.date)
        }
        
        class Helper {
            public var dateChanged: (() -> Void)?
            public var doneButtonTapped: (() -> Void)?
            
            @objc func dateValueChanged(){
                self.dateChanged?()
            }
            
            @objc func doneButtonAction(){
                self.doneButtonTapped?()
            }
        }
        
    }
    
}

#Preview{
    VStack{
        Component.titleSignPage(text: "Ayung")
        
        Component.bottomSignText(text: "Already have an account?", blueText: "sfdsdf") {
            //
        }
        
    }
}
