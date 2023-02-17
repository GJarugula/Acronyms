//
//  View+Extension.swift
//  Acronyms
//
//  Created by Gayathri Jarugula on 2/17/23.
//

import SwiftUI

extension View {
    /// Hide or Show a View based on a Bool Value
    /// - Parameter hidden: to make the View hide, make it true.
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}
