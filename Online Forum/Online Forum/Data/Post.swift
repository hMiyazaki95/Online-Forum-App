//
//  Post.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//
// Assuming Post is a struct conforming to Identifiable and Codable
import UIKit

struct Post: Identifiable, Codable {
    var id: UUID
    var subject: String
    var text: String
    var imageData: Data?
    var status: PostStatus

    enum PostStatus: String, Codable {
        case approved
        case pending
    }
    init(id: UUID, subject: String, text: String, image: UIImage?, status: PostStatus) {
            self.id = id
            self.subject = subject
            self.text = text
            self.imageData = image?.jpegData(compressionQuality: 1.0)
            self.status = status
        }

        var image: UIImage? {
            if let imageData = self.imageData {
                return UIImage(data: imageData)
            }
            return nil
        }
}
