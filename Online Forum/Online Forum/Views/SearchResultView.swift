//
//  SearchResultView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/14/23.
//

import SwiftUI

struct SearchResultView: View {
    @Binding var searchQuery: String
    var dataStore: DataStore
    @Binding var selectedChannelID: UUID?

    var body: some View {
        Group {
            if !searchQuery.isEmpty {
                List {
                    ForEach(filteredChannels, id: \.id) { channel in
                        Button(action: {
                            selectedChannelID = channel.id
                        }) {
                            Text(channel.name)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }

    private var filteredChannels: [Channel] {
        if searchQuery.isEmpty {
            return []
        } else {
            return dataStore.channels.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchQuery: .constant(""), dataStore: DataStore(), selectedChannelID: .constant(UUID()))
    }
}
