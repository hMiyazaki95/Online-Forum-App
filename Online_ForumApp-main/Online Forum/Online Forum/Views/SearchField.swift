//
//  SearchField.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/14/23.
//

import SwiftUI

struct SearchField: View {
    @Binding var searchQuery: String

    var body: some View {
        TextField("Search Channel", text: $searchQuery)
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(searchQuery: .constant(""))
    }
}
