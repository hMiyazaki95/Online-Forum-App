//
//  CommonStyle.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/12/23.
//

import SwiftUI

struct CommonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

// Create a view to preview the button style
struct CommonButtonStyle_Preview: View {
    var body: some View {
        Button("Click Me") {
            // Action for the button
        }
        .buttonStyle(CommonButtonStyle()) // Apply your custom button style
    }
}

// Preview provider
struct CommonButtonStyle_Preview_Previews: PreviewProvider {
    static var previews: some View {
        CommonButtonStyle_Preview()
    }
}
