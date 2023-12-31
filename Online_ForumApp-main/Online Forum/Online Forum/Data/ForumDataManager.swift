//
//  ForumDataManager.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import Foundation


class ForumDataManager {
    static let shared = ForumDataManager()
    private let postsKey = "forumPosts"

    func loadPosts() -> [ForumPost] {
        guard let data = UserDefaults.standard.data(forKey: postsKey),
              let posts = try? JSONDecoder().decode([ForumPost].self, from: data) else {
            return []
        }
        return posts
    }

    func savePost(_ post: ForumPost) {
        var posts = loadPosts()
        posts.append(post)
        if let data = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(data, forKey: postsKey)
        }
    }

    func deletePost(at offsets: IndexSet, currentUserID: UUID) {
        var posts = loadPosts()

        // Perform deletion on the original posts
        posts.remove(atOffsets: offsets)

        // Re-encode and save the updated posts array
        if let data = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(data, forKey: postsKey)
        }
    }

}


