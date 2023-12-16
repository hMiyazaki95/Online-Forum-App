//
//  GreenButton.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/13/23.
//

import SwiftUI

struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
// Create a view to preview the button style
struct GreenButton_Preview: View {
    var body: some View {
        Button("Click Me") {
            // Action for the button
        }
        .buttonStyle(GreenButton()) // Apply your custom button style
    }
}

// Preview provider
struct GreenButton_Preview_Previews: PreviewProvider {
    static var previews: some View {
        CommonButtonStyle_Preview()
    }
}
