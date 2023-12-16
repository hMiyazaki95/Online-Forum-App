//
//  ChannelListView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//


import SwiftUI

struct ChannelListView: View {
    @ObservedObject var dataStore: DataStore
    @Binding var searchQuery: String
    @State private var showingChannelPostingView = false
    let currentUserID: UUID
    
    
    // In ChannelListView.swift

    init(dataStore: DataStore, searchQuery: Binding<String>, currentUserID: UUID) {
        self.dataStore = dataStore
        self._searchQuery = searchQuery
        self.currentUserID = currentUserID
    }


    var body: some View {
        NavigationView {
            List(dataStore.channels, id: \.id) { channel in
                NavigationLink(destination: ForumView(dataStore: dataStore, channelID: channel.id, currentUserID: currentUserID)) {
                    HStack {
                        Text(channel.name) // Add other channel info as needed
                    }
                }
            }
            .navigationBarTitle("Channels")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingChannelPostingView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingChannelPostingView) {
            }
        }
    }
}

struct ChannelListView_Previews: PreviewProvider {
    static var previews: some View {
            let mockDataStore = DataStore()
            let dummyUserID = UUID()

            ChannelListView(dataStore: mockDataStore, searchQuery: .constant(""), currentUserID: dummyUserID)
        }
}
