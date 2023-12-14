//
//  MainTabView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import SwiftUI

struct MainTabView: View {
    @Binding var isAuthenticated: Bool
    @State private var selectedTab = 0
    @ObservedObject var dataStore: DataStore
    let currentUserID: UUID

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                DashboardView(isAuthenticated: $isAuthenticated)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Dashboard")
            }
            .tag(0)

            NavigationView {
                ChannelListView(dataStore: dataStore, currentUserID: currentUserID)
            }
            .tabItem {
                Image(systemName: "bubble.left.fill")
                Text("Channels")
            }
            .tag(1)

            NavigationView {
                PostingView(dataStore: dataStore, channelID: UUID())
            }
            .tabItem {
                Image(systemName: "pencil.circle.fill")
                Text("Post")
            }
            .tag(2)
        }
    }
}




struct RoundedCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct ColorConstants {
    static let primaryColor = Color("PrimaryColor")
    static let secondaryColor = Color("SecondaryColor")
    // Define other color constants as needed
}

struct StringConstants {
    static let appName = "Your App Name"
    // Define other string constants as needed
}

enum FontScheme {
    static let largeTitle = Font.system(size: 36).weight(.bold)
    static let title = Font.system(size: 24).weight(.bold)
    static let body = Font.system(size: 16)
    // Define other font styles as needed
}

// Preview for MainTabView
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(isAuthenticated: .constant(true), dataStore: DataStore(), currentUserID: UUID())
    }
}
