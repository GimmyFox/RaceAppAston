//
//  UIGrid.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 28.11.2023.
//

import Foundation
import UIKit

enum UIGrid {
    
    enum ScreenSize {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
    }

    
    enum Padding {
        static let padding5: CGFloat = 5
        static let padding10: CGFloat = 10
        static let padding16: CGFloat = 16
        static let padding20: CGFloat = 20
    }
    
    enum CornerRadius {
        static let cr10: CGFloat = 10
        static let cr16: CGFloat = 16
        static let cr24: CGFloat = 24
    }
    
    enum Spacing {
        static let spacing5: CGFloat = 5
        static let spacing10: CGFloat = 10
        static let spacing15: CGFloat = 15
        static let spacing20: CGFloat = 20
    }
    
    enum Height {
        static let oneLineDefaultLabel: CGFloat = 20
    }
}
