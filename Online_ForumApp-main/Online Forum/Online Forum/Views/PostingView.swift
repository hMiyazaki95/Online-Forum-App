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
    @State private var selectedChannelName: String?
    @State private var subject = ""
    @State private var text = ""
    @State private var showingImagePicker = false
    @State private var image: UIImage?
    @State private var searchQuery = ""
    @State private var showingChannelCreationView = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Search Channel", text: $searchQuery)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    if !searchQuery.isEmpty {
                        List(searchResults, id: \.id) { channel in
                            Button(action: {
                                selectChannel(channel)
                            }) {
                                Text(channel.name)
                                    .padding()
                            }
                        }
                        .listStyle(PlainListStyle())
                    }

                    if let channelName = selectedChannelName {
                        Text("Selected Channel: \(channelName)")
                            .padding()
                    }

                    Button("Create New Channel") {
                        showingChannelCreationView = true
                    }
                    .buttonStyle(ConsistentButtonStyle(backgroundColor: Color.blue))
                    .padding(.bottom)
                    .sheet(isPresented: $showingChannelCreationView) {
                        ChannelPostingView(isPresented: $showingChannelCreationView, dataStore: dataStore)
                    }

                    TextField("Title", text: $subject)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button("Upload photo") {
                        showingImagePicker = true
                    }
                    .buttonStyle(ConsistentButtonStyle(backgroundColor: Color.gray.opacity(0.5)))
                    .padding(.bottom)

                    if let _ = image {
                        Text("Image selected") // Placeholder for image preview
                            .padding()
                    }

                    TextEditor(text: $text)
                        .frame(height: 200)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.horizontal)

                    Button("Post") {
                        submitPost()
                    }
                    .buttonStyle(ConsistentButtonStyle(backgroundColor: Color.green))
                    .padding(.bottom)
                }
            }
            .navigationBarTitle("Upload a new photo")
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showingImagePicker) {
                // Placeholder for ImagePicker
            }
        }
    }

    private var searchResults: [Channel] {
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

    private func submitPost() {
        let channelToPost = selectedChannelID ?? channelID
        let newPost = Post(id: UUID(), subject: subject, text: text, image: image, status: .pending)
        dataStore.addPost(newPost, toChannel: channelToPost)
        clearInputFields()
    }

    private func clearInputFields() {
        subject = ""
        text = ""
        image = nil
        selectedChannelID = nil
        selectedChannelName = nil
    }
}

struct ConsistentButtonStyle: ButtonStyle {
    var backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .padding(.horizontal, 30)
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(dataStore: DataStore(), channelID: UUID())
    }
}
