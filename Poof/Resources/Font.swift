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
    
    static var systemTitle: Font {
        return .system(size: 21, weight: .semibold)
    }
    
    static var systemTitle2: Font {
        return .system(size: 27, weight: .bold)
    }
    
    static var systemSubheader: Font {
        return .system(size: 21, weight: .semibold)
    }
    
    static var systemHeadline2: Font {
        return .system(size: 16, weight: .medium)
    }
    
    static var systemBodyText: Font {
        return .system(size: 16, weight: .regular)
    }
    
    static var systemButtonText: Font {
        return .system(size: 19, weight: .medium)
    }
}



