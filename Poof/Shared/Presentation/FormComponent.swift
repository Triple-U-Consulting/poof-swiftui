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
        @Binding var menuSelection: [String]
        var body: some View {
            Menu {
                Picker("", selection: $selection) {
                    ForEach(menuSelection, id: \.self) { option in
                        Text(option)
                    }
                }
//                ForEach(array, id:\.self) { item in
//                    Button {
//                        selection = item
//                    } label: {
//                        HStack {
////                            Text(Image(systemName:"checkmark"))
//                            Text(item)
//                                .foregroundStyle(.black)
////                                .frame(maxWidth: 10)
//                        }
//                        .frame(maxWidth: 10)
//                    }
//                }
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
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.horizontal, 8)
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
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.horizontal, 8)
                
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
    
    struct FormSlider : View {
        
        @Binding var value : Double
        @Binding var toggle : Bool
        
        var step: Double = 1
        
        var body: some View {

            VStack(spacing: 0) {
                if !toggle {
                    Slider(
                        value: $value,
                        in: 0...4,
                        step: step,
                        minimumValueLabel: {
                            VStack {
                                Image("formSliderMinimum")
                                    .resizable()
                                    .frame(width: 24, height: 25)
                                    .padding(.trailing, 0)
                            }
                        }(),
                        maximumValueLabel: {
                            VStack {
                                Image("formSliderMaximum")
                                    .resizable()
                                    .frame(width: 24, height: 25)
                                    .padding(.leading, 0)
                            }
                        }(),
                        label: {
                            //
                        }
                    )
                    .accentColor(Color.Main.blueTextSecondary)
                    .disabled(toggle)
                    
                    
                    HStack(spacing: 0) {
                        ForEach(0..<5) { index in
                            VStack {
                                Text("\(index * Int(step) + Int(0))")
                            }
                            if index != 4 {
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.leading, 2)
                    .padding(.vertical, 8)
                }
                
                HStack (spacing:0){
                    Component.DefaultText(text: "Tidak yakin dengan skala sesak", textAlignment: .leading)
                        .font(.footnote)
                        .lineLimit(1...1)

                    Spacer()
                    Toggle("", isOn: $toggle)
                        .frame(width: 100)
                }
            }
        }
    }
    
}


struct FormComponent: View {
    
    @State var count = 0
    @State var sesak: Double = 0
    @State var state : String = "unselected"
    @State var toggle : Bool = false
    
    var body: some View {
        Component.TextWithBorder(text: "\(count)")
            .onTapGesture {
                count+=1
            }
        Divider()
        Component.MenuWithBorder(selection: $state, menuSelection: .constant(["a", "b", "c"]))
        Text("Selected item : \(state)")
        Divider()
        Component.Stepper(value: $count)
        Divider()
        Component.FormSlider(value: $sesak, toggle: $toggle)
        Text("\(sesak)")
    }
}

#Preview {
    FormComponent()
}
