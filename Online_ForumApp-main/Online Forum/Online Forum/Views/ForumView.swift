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
            List(dataStore.posts(for: channelID)) { post in
                VStack(alignment: .leading, spacing: 10) {
                    Text(post.subject)
                        .font(.headline)
                        .foregroundColor(Color("TextPrimary")) // Use color assets for dynamic theming

                    if let imageData = post.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }

                    Text(post.text)
                        .foregroundColor(Color("TextSecondary")) // Use color assets for dynamic theming
                }
                .padding()
                .background(Color("PostBackground")) // Use color assets for dynamic theming
                .cornerRadius(12)
                .listRowBackground(Color.clear)
            }
            .alert(isPresented: $showingEmptyChannelAlert) {
                Alert(title: Text("Empty Channel"), message: Text("This channel has no posts."), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle(Text("Feed"), displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                // Action to present PostingView
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color("NavigationIcon")) // Use color assets for dynamic theming
            })
            .onAppear {
                showingEmptyChannelAlert = dataStore.posts(for: channelID).isEmpty
            }
        }
        .background(Color("BackgroundPrimary").edgesIgnoringSafeArea(.all)) // Use color assets for dynamic theming
    }

    private func deletePost(at offsets: IndexSet) {
        dataStore.deletePost(at: offsets, inChannel: channelID)
        showingEmptyChannelAlert = dataStore.posts(for: channelID).isEmpty
    }
}

// Preview
struct ForumView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataStore = DataStore()
        let dummyChannelID = UUID()
        let dummyUserID = UUID()

        ForumView(dataStore: mockDataStore, channelID: dummyChannelID, currentUserID: dummyUserID)
            .preferredColorScheme(.dark) // Or .light for light mode preview
    }
}

