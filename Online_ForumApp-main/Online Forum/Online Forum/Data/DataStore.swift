//
//  DataStore.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//




import SwiftUI

class DataStore: ObservableObject {
    @Published var channels: [Channel] = []

    // Adds a post to a specific channel
    func addPost(_ post: Post, toChannel channelID: UUID) {
        if let index = channels.firstIndex(where: { $0.id == channelID }) {
            channels[index].posts.append(post)
        }
    }

    // Returns posts for a specific channel
    func posts(for channelID: UUID) -> [Post] {
        channels.first { $0.id == channelID }?.posts ?? []
    }

    // Deletes a post from a specific channel
    func deletePost(at offsets: IndexSet, inChannel channelID: UUID) {
        if let index = channels.firstIndex(where: { $0.id == channelID }) {
            channels[index].posts.remove(atOffsets: offsets)
        }
    }

    // Adds a new channel
    func addChannel(name: String, description: String, imageName: String) {
        let newChannel = Channel(
            id: UUID(),
            name: name,
            description: description,
            image: imageName,
            posts: []
        )
        channels.append(newChannel)
    }

    // Saves an image and returns a filename
    func saveImage(_ image: UIImage) -> String? {
        // Generate a unique filename for the image
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent("\(imageName).jpg")

        // Convert the image to JPEG data
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
            return imageName // or imagePath.path if you need the full path
        }

        return nil
    }

    // Helper function to get the documents directory
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}



//struct Post: Identifiable {
//    var id: UUID
//    // Add other properties as needed
//}
