//
//  ColorStyle.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/12/23.
//

import SwiftUI

struct ColorStyle: Style {
    struct ColorConstants {
        static let primaryColor = Color.blue // Replace with your primary color
        static let secondaryColor = Color.green // Replace with your secondary color
    }

    // Define your font scheme here
    enum FontScheme {
        static let largeTitle = Font.system(size: 36).weight(.bold)
        static let title = Font.system(size: 24).weight(.bold)
        static let body = Font.system(size: 16)
    }
}

#Preview {
    ColorStyle()
}
