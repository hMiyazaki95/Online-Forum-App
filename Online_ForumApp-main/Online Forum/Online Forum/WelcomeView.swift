//
//  WelcomeView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var showLogin: Bool
    @Binding var showWelcome: Bool

    var body: some View {
        VStack {
            Text("Welcome to Online Forum")
                .font(.largeTitle)
                .padding()

            Button("Let's Get Started") {
                withAnimation {
                    showWelcome = false
                    showLogin = true
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(showLogin: .constant(false), showWelcome: .constant(true))
    }
}
