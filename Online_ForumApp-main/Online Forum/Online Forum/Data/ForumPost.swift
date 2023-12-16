//
//  ForumPost.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import Foundation

struct ForumPost: Identifiable, Codable, Equatable {
    var id: UUID
    var userID: UUID  // User ID of the person who created the post
    var subject: String
    var text: String
    var imageData: Data?  // Optional property to store image data

    init(id: UUID = UUID(), userID: UUID, subject: String, text: String, imageData: Data? = nil) {
        self.id = id
        self.userID = userID
        self.subject = subject
        self.text = text
        self.imageData = imageData
    }
}
