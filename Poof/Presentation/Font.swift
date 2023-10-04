//
//  Font.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 04/10/23.
//

import Foundation
import SwiftUI


// Usage example:
//Text("Hello, SwiftUI!")
//    .font(.title2)

extension Font {
    
    static var title: Font {
        return .system(size: 21, weight: .semibold)
    }
    
    static var title2: Font {
        return .system(size: 27, weight: .bold)
    }
    
    static var subheader: Font {
        return .system(size: 21, weight: .semibold)
    }
    
    static var headline2: Font {
        return .system(size: 16, weight: .medium)
    }
    
    static var bodyText: Font {
        return .system(size: 16, weight: .regular)
    }
    
    static var buttonText: Font {
        return .system(size: 19, weight: .medium)
    }
}
