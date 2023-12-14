//
//  ChannelListView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//



import SwiftUI

struct ChannelListView: View {
    @ObservedObject var dataStore: DataStore
    let currentUserID: UUID

    var body: some View {
        NavigationView {
            List(dataStore.channels, id: \.id) { channel in
                NavigationLink(destination: ForumView(dataStore: dataStore, channelID: channel.id, currentUserID: currentUserID)) {
                    HStack {
                        // Image View
                        if let uiImage = loadImage(forChannel: channel) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50) // Adjust size as needed
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "photo") // Placeholder image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(channel.name)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(channel.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        // Optionally, add an icon or image for the channel
                        Image(systemName: "folder")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle("Channels", displayMode: .inline)
        }
    }

    // Function to load image from the file system
    private func loadImage(forChannel channel: Channel) -> UIImage? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let imagePath = paths[0].appendingPathComponent("\(channel.image).jpg")
        if let imageData = try? Data(contentsOf: imagePath) {
            return UIImage(data: imageData)
        }
        return nil
    }
}

struct ChannelListView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelListView(dataStore: DataStore(), currentUserID: UUID())
    }
}
