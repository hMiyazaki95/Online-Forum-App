//
//  Channel.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//



import Foundation

struct Channel: Identifiable {
    var id: UUID
    var name: String
    var description: String
    var image: String
    var posts: [Post]
}
