//
//  Binding+Extensions.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-03.
//

import Foundation
import SwiftUI

extension Binding where Value: Equatable {
    
    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
        self.init(
            get: { source.wrappedValue ?? nilProxy },
            set: { newValue in
                if newValue == nilProxy {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
        })
    }
}
