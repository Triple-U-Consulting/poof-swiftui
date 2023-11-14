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
//    .font(.systemTitle)

extension Font {
    
    static var systemTitle1: Font {
        return .system(size: 28, weight: .semibold)
    }
    
    static var systemTitle2: Font {
        return .system(size: 22, weight: .semibold)
    }
    
    static var systemTitle3: Font {
        return .system(size: 20, weight: .semibold)
    }
    
    static var systemSubheader: Font {
        return .system(size: 22, weight: .semibold)
    }
    
    static var systemHeadline: Font {
        return .system(size: 17, weight: .medium)
    }
    
    static var systemBodyText: Font {
        return .system(size: 17, weight: .regular)
    }
    
    static var systemButtonText: Font {
        return .system(size: 20, weight: .medium)
    }
    
    static var systemFootnote: Font {
        return .system(size: 15, weight: .regular)
    }
    
    static var test: Font {
        return .custom("SFProText-Regular", size: 17, relativeTo: .body)
    }
    
}



