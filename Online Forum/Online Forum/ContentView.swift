//
//  ContentView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//
// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false
    @State private var showLogin = false
    @State private var showWelcome = true
    @StateObject var dataStore = DataStore()
    

    var body: some View {
        ZStack {
            if isAuthenticated {
                // Pass the isAuthenticated state to MainTabView
                MainTabView(isAuthenticated: $isAuthenticated, dataStore: dataStore, currentUserID: UUID())
            } else if showWelcome {
                WelcomeView(showLogin: $showLogin, showWelcome: $showWelcome)
            } else if showLogin {
                LoginView(isAuthenticated: $isAuthenticated)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
