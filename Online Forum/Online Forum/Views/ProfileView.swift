//
//  ProfileView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//
import SwiftUI

struct ProfileView: View {
    @AppStorage("userName") var userName = "Hajime"
    @AppStorage("userEmail") var userEmail = "hmiyazaki@example.com"
    @State private var isEditingProfile = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ProfileImage() // Circular profile image

                Text(userName)
                    .font(.title)
                    .fontWeight(.bold)

                Text(userEmail)
                    .font(.body)
                    .foregroundColor(.secondary)

                Button("Edit Profile") {
                    isEditingProfile = true
                }
                .buttonStyle(CommonButtonStyle())
                .sheet(isPresented: $isEditingProfile) {
                    EditProfileView(userName: $userName, userEmail: $userEmail)
                }

                Spacer()
            }
            .padding()
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct ProfileImage: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill") // Replace with actual image logic
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.blue, lineWidth: 4))
            .shadow(radius: 10)
            .padding(.top, 20)
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
