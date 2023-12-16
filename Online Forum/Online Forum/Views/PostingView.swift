//
//  PostingView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//


import SwiftUI

struct PostingView: View {
    @ObservedObject var dataStore: DataStore
    var channelID: UUID
    @State private var selectedChannelID: UUID?
    @State private var selectedChannelName: String = ""
    @State private var subject = ""
    @State private var text = ""
    @State private var showingImagePicker = false
    @State private var image: UIImage?
    @State private var searchQuery = ""
    @State private var showingChannelPostingView = false
    @State private var channelCreated = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    searchField
                    searchResultsView
                    createChannelButton
                    PostDetailsForm(
                        subject: $subject,
                        text: $text,
                        showingImagePicker: $showingImagePicker,
                        image: $image,
                        selectedChannelID: selectedChannelID ?? UUID(), 
                        dataStore: dataStore,
                        selectedChannelName: $selectedChannelName
                    )
                    Button("Submit Post") {
                        submitPost()
                    }
                    .buttonStyle(CommonButtonStyle())
                    .padding()
                    .disabled(!isFormValid())
                }

            }
            .navigationBarTitle("Post to Channel")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $image)
            }
            .sheet(isPresented: $showingChannelPostingView) {
                ChannelPostingView(dataStore: dataStore, isPresented: $showingChannelPostingView, channelCreated: $channelCreated)
            }

        }
    }

    private var searchField: some View {
        TextField("Search Channel", text: $searchQuery)
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top)
    }

    private var searchResultsView: some View {
        Group {
            if !searchQuery.isEmpty {
                VStack(alignment: .leading) {
                    ForEach(filteredChannels, id: \.id) { channel in
                        Text(channel.name)
                            .padding()
                            .onTapGesture {
                                selectChannel(channel)
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
    }

    private var createChannelButton: some View {
        Button("Create New Channel") {
            showingChannelPostingView = true
            // Implement action to create new channel
        }
        .buttonStyle(CommonButtonStyle())
        .padding(.bottom)
    }

    private var filteredChannels: [Channel] {
        if searchQuery.isEmpty {
            return []
        } else {
            return dataStore.channels.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    private func selectChannel(_ channel: Channel) {
        selectedChannelID = channel.id
        selectedChannelName = channel.name
        searchQuery = ""
    }

    private func loadImage() {
        guard let selectedImage = image else { return }
        self.image = selectedImage
    }
    
    // Check if the form is valid for submission
    private func isFormValid() -> Bool {
        // Implement validation logic here
        // For example, check if all required fields are filled in
        return !subject.isEmpty && !text.isEmpty && selectedChannelID != nil
    }

    private func submitPost() {
        // Ensure all required fields are filled
        guard !subject.isEmpty, !text.isEmpty, let channelId = selectedChannelID else {
            // Handle error if needed
            return
        }

        // Create a new Post object
        let newPost = Post(id: UUID(), subject: subject, text: text, image: image, status: .pending)

        // Add the new post to the data store
        dataStore.addPost(newPost, toChannel: channelId)

        // Clear form fields after submission
        clearForm()
    }


    private func clearForm() {
        // Clear all form fields
        selectedChannelID = nil
        selectedChannelName = ""
        subject = ""
        text = ""
        image = nil
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(dataStore: DataStore(), channelID: UUID())
    }
}
