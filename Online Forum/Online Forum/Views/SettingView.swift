//
//  SwiftUIView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/12/23.
//

import SwiftUI

struct SettingView: View {
    @Binding var userName: String
    @Binding var userEmail: String

    var body: some View {
        Form {
            TextField("Name", text: $userName)
            TextField("Email", text: $userEmail)
        }
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}

// Preview for SettingsView
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(userName: .constant("Hajime Miyazaki"), userEmail: .constant("hmiyazaki@example.com"))
    }
}
