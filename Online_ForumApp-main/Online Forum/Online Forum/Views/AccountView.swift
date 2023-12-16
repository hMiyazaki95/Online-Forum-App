//
//  AccountView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/11/23.
//
import SwiftUI

import SwiftUI

struct AccountView: View {
    @Binding var isAuthenticated: Bool
    @State private var showEditProfile = false
    @State private var showSettings = false

    // Replace these with actual user data
    @State private var userName: String = "Hajime" // Default username
    @State private var userEmail: String = "hmiyazaki@example.com" // Default email
    // Add the path to your user's profile image here
    let profileImagePath: String = "profileImage"

    var body: some View {
        VStack {
            Spacer().frame(height: 50) // Spacing from top

            // Profile Image
            Image(profileImagePath) // Replace with actual image logic
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.bottom, 20)

            // Username and Email
            Text(userName)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 2)

            Text(userEmail)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom, 20)

            // Buttons for Edit Profile, Settings, and Log Out
            Button(action: { showEditProfile = true }) {
                Label("Edit Profile", systemImage: "pencil")
            }
            .buttonStyle(CommonButtonStyle())
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(userName: $userName, userEmail: $userEmail)
            }

            Button(action: { showSettings = true }) {
                Label("Settings", systemImage: "gear")
            }
            .buttonStyle(CommonButtonStyle())
            .sheet(isPresented: $showSettings) {
                SettingView(userName: $userName, userEmail: $userEmail)
            }

            Button(action: {
                isAuthenticated = false // Log out and show login view
            }) {
                Label("Log Out", systemImage: "arrow.right.square")
            }
            .buttonStyle(CommonButtonStyle())

            Spacer()
        }
        .padding()
        .navigationBarTitle("Account", displayMode: .inline)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(isAuthenticated: .constant(true))
    }
}
