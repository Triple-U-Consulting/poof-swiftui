//
//  Color+Theme.swift
//  Poof
//
//  Created by Geraldy Kumara on 08/10/23.
//

import SwiftUI

/// For folder Main
extension Color {
    struct Main {
        static let primary1 = Color("primary1")
        static let primary2 = Color("primary2")
        static let primary3 = Color("primary3")
        static let primary4 = Color("primary4")
        static let primary5 = Color("primary5")
        static let blueText = Color("blueText")
        static let blueTextSecondary = Color("blueTextSecondary")
        static let backgroundTitleCard = Color("backgroundTitleCard")
        static let backgroundTitleReportCard = Color("backgroundTitleReportCard")
    }
}

// For Semantic
extension Color {
    struct Secondary {
        static let secondary1 = Color("secondary1")
        static let secondary2 = Color("secondary2")
        static let secondary3 = Color("secondary3")
        static let pdfSecondary = Color("pdfSecondary")
    }
}

// For Neutrals
extension Color {
    struct Neutrals {
        //static let systemWhite = Color("white")
       // static let systemBlack = Color("black")
        static let gray1 = Color("gray1")
        static let gray2 = Color("gray2")
        static let gray3 = Color("gray3") //for shadow button
        static let gray4 = Color("gray4")
        static let gray5 = Color("gray5")
        static let gray6 = Color("gray6")
        static let sheetBackground = Color("gray7")
        static let gray8 = Color("gray8")
        static let titleSignPage = Color("gray4")
        static let grayBottomSignText = Color("gray5")
    }
}

extension UIColor{
    struct UIMain {
        static let blueTitlePdf = UIColor(named: "blueTitlePdf")!
    }
}
