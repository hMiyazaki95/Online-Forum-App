//
//  ChannelImage.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import SwiftUI

struct ChannelImage: View {
    let imagePath: String

    var body: some View {
        if let uiImage = UIImage(contentsOfFile: imagePath) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: "photo")  // Placeholder image
                .resizable()
                .scaledToFit()
        }
    }
}

