//
//  LoginView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import SwiftUI

struct LoginView: View {
    @Binding var isAuthenticated: Bool
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 120) // Space at the top for the title

                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .padding()

                Button(action: {
                    // Perform authentication logic here
                    isAuthenticated = true // Replace with actual authentication logic
                }) {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue) 
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)

                // Navigation link to SignUpView
                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(Color.blue)
                        .underline()
                }
                .padding(.bottom, 10)

                Spacer() // Pushes everything to the top
            }
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGroupedBackground)) // Use a system background color
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isAuthenticated: .constant(false))
    }
}
