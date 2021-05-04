//
//  Color+Extensions.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-03.
//

import Foundation
import SwiftUI

extension Color {

    static var primaryColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .white : .black })
    }
    
    static var backgroundColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .darkGray : .white })
    }
}
