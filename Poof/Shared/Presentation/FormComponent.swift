//
//  FormComponent.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 22/11/23.
//

import SwiftUI

extension Component {
    struct TextWithBorder: View {
        var text: String
        var body: some View {
            Component.DefaultText(text: text)
                .font(.systemBodyText)
                .foregroundStyle(.black)
                .padding(.horizontal, 16)
                .frame(height: 32)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.primary1, lineWidth: 1)
                )
        }
    }

    struct MenuWithBorder: View {
        @Binding var selection: String
        @Binding var array: [String]
        var body: some View {
            Menu {
                ForEach(array, id:\.self) { item in
                    Button {
                        selection = item
                    } label: {
                        Text(item)
                            .frame(maxWidth: 10)
                    }
                }
            } label: {
                VStack {
                    HStack {
                        Component.DefaultText(text: "\(selection)")
                            .font(.systemBodyText)
                        Image(systemName: "chevron.up.chevron.down")
                    }
                }
                    .font(.systemBodyText)
                    .foregroundColor(.black)
                    .frame(height: 32)
                    .padding(.horizontal, 12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.primary1, lineWidth: 1)
                    }
            }
            .menuOrder(.fixed)
        }
    }
    
    struct Stepper : View {
        @Binding var value : Int
        var body: some View {
            HStack {
                Button { value -= 1 } label : {
                    Image(systemName: "minus")
                        .foregroundStyle(value <= 0 ? .gray : .black)
                    }.padding(.horizontal, 8)
                    .disabled(value <= 0)
                
                Divider()
                    .frame(height: 24)
                Component.DefaultText(text: "\(value)")
                    .frame(width: 40)
                Divider()
                    .frame(height: 24)
                
                Button { value += 1 } label : {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                    }.padding(.horizontal, 8)
                
            }
            .frame(minWidth: 120)
            .frame(height: 32)
            .padding(.horizontal, 12)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.primary1, lineWidth: 1)
            }
        }
    }
    
}


struct FormComponent: View {
    
    @State var count = 0
    @State var state : String = "unselected"
    
    var body: some View {
        Component.TextWithBorder(text: "\(count)")
            .onTapGesture {
                count+=1
            }
        Divider()
        Component.MenuWithBorder(selection: $state, array: .constant(["a", "b", "c"]))
        Text("Selected item : \(state)")
        Divider()
        Component.Stepper(value: $count)
    }
}

#Preview {
    FormComponent()
}
