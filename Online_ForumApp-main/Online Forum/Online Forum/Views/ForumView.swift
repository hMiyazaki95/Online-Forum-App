//
//  ForumView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//


import SwiftUI

struct ForumView: View {
    @ObservedObject var dataStore: DataStore
    let channelID: UUID
    let currentUserID: UUID
    @State private var showingEmptyChannelAlert = false

    var body: some View {
        NavigationView {
            List {
                ForEach(dataStore.posts(for: channelID)) { post in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(post.subject)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if let imageData = post.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }

                        Text(post.text)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(12)
                    .listRowBackground(Color.clear)
                }
                .onDelete(perform: deletePost)
            }
            .alert(isPresented: $showingEmptyChannelAlert) {
                Alert(title: Text("Empty Channel"), message: Text("This channel has no posts."), dismissButton: .default(Text("OK")))
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitle(Text("Feed"), displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                // Action to present PostingView
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.white)
            })
            .onAppear {
                showingEmptyChannelAlert = dataStore.posts(for: channelID).isEmpty
            }
        }
    }

    private func deletePost(at offsets: IndexSet) {
        dataStore.deletePost(at: offsets, inChannel: channelID)
        showingEmptyChannelAlert = dataStore.posts(for: channelID).isEmpty
    }
}

struct ForumView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataStore = DataStore()
        let dummyChannelID = UUID()
        let dummyUserID = UUID()

        ForumView(dataStore: mockDataStore, channelID: dummyChannelID, currentUserID: dummyUserID)
            .preferredColorScheme(.dark)
    }
}
