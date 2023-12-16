//
//  CreateChannelButton.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/14/23.
//

import SwiftUI

struct CreateChannelButton: View {
    @Binding var showingChannelPostingView: Bool

    var body: some View {
        Button("Create New Channel") {
            showingChannelPostingView = true
        }
        .buttonStyle(CommonButtonStyle())
        .padding(.bottom)
    }
}

struct CreateChannelButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateChannelButton(showingChannelPostingView: .constant(false))
    }
}

