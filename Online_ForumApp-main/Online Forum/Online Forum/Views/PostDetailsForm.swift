//
//  PostDetailsForm.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/14/23.
//


import SwiftUI

struct PostDetailsForm: View {
    @Binding var subject: String
    @Binding var text: String
    @Binding var showingImagePicker: Bool
    @Binding var image: UIImage?
    var selectedChannelID: UUID
    var dataStore: DataStore
    @Binding var selectedChannelName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Channel Information
            if !selectedChannelName.isEmpty {
                Text("Selected Channel: \(selectedChannelName)")
                    .padding()
            } else {
                Text("No Channel Selected")
                    .padding()
            }

            // Title Field
            TextField("Title", text: $subject)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

            // Text Editor
            TextEditor(text: $text)
                .frame(height: 200)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

            // Image
            if let selectedImage = image {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
            } else {
                Text("No Image Selected")
                    .frame(height: 200)
            }

            // Buttons
            HStack {
                Button("Upload photo") {
                    showingImagePicker = true
                }
                .buttonStyle(CommonButtonStyle())
            }
        }
        .padding()
    }

    private func submitPost() {
        let channelIDToPost = selectedChannelID
        let newPost = Post(id: UUID(), subject: subject, text: text, image: image, status: .pending)
        dataStore.addPost(newPost, toChannel: channelIDToPost)
        clearInputFields()
    }

    private func clearInputFields() {
        subject = ""
        text = ""
        image = nil
    }
}

struct PostDetailsForm_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsForm(
            subject: .constant("Sample Subject"),
            text: .constant("Sample Text"),
            showingImagePicker: .constant(false),
            image: .constant(nil),
            selectedChannelID: UUID(),
            dataStore: DataStore(),
            selectedChannelName: .constant("Sample Channel")
        )
    }
}
