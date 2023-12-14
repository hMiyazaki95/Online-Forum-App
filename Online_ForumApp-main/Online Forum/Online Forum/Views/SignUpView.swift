//
//  SignUpView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        NavigationView {
            VStack {
                // Title "Sign Up"
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary) // Use the primary color for the title
                    .padding(.top, 100) // Add space from the top edge

                VStack(spacing: 20) { // Add spacing between input fields
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .padding()

                // Submit button
                Button(action: {
                    // Handle sign up logic here
                }) {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue) // Consider using your app's theme color here
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20) // Add space from the bottom edge

                Spacer()
            }
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGroupedBackground)) // Use a system background color
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


