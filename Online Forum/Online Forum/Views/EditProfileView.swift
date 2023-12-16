//
//  EditProfileView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/12/23.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var userName: String
    @Binding var userEmail: String

    var body: some View {
        VStack {
            Text("Edit Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Username", text: $userName)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

            TextField("Email", text: $userEmail)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

            Button("Save Changes") {
                // Handle saving logic here
            }
            .buttonStyle(CommonButtonStyle())
            .padding(.top)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Edit Profile", displayMode: .inline)
    }
}

// Preview for EditProfileView
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(userName: .constant("John Doe"), userEmail: .constant("johndoe@example.com"))
    }
}
