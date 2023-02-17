//
//  Loader.swift
//  Acronyms
//
//  Created by Gayathri Jarugula on 2/17/23.
//

import SwiftUI

struct Loader<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                VStack {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: 86,
                       height: 86)
                .background(Color(red: 0.961, green: 0.961, blue: 0.961))
                .foregroundColor(Color.primary)
                .cornerRadius(4)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}
