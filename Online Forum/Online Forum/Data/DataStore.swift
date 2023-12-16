//
//  DataStore.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

//import UIKit
//import SwiftUI
//
//class DataStore: ObservableObject {
//    @Published var channels: [Channel] = [] // Store your channels here
//    
//    // Add new channel to the data store
//       func addChannel(name: String, image: String) {
//           let newChannel = Channel(id: UUID(), name: name, image: image, posts: [])
//           channels.append(newChannel)
//           print("Added new channel: \(newChannel)")
//           print("Current channels: \(channels)")
//       }
//
//       // Add a new post to a specific channel
//       func addPost(_ post: Post, toChannel channelID: UUID) {
//           if let index = channels.firstIndex(where: { $0.id == channelID }) {
//               channels[index].posts.append(post)
//               print("Added post to channel: \(channels[index])")
//           }
//       }
//
//    
//    func saveImage(_ image: UIImage) -> String? {
//        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return nil }
//        let filename = getDocumentsDirectory().appendingPathComponent("channel_image.jpg")
//        try? data.write(to: filename)
//        return filename.path
//    }
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//}



import SwiftUI

class DataStore: ObservableObject {
    @Published var channels: [Channel] = []

    func addPost(_ post: Post, toChannel channelID: UUID) {
        if let index = channels.firstIndex(where: { $0.id == channelID }) {
            channels[index].posts.append(post)
        }
    }

    func posts(for channelID: UUID) -> [Post] {
        channels.first { $0.id == channelID }?.posts ?? []
    }

    func deletePost(at offsets: IndexSet, inChannel channelID: UUID) {
        if let index = channels.firstIndex(where: { $0.id == channelID }) {
            channels[index].posts.remove(atOffsets: offsets)
        }
    }
    
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

        private func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
}
