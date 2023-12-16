//
//  MainTabView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @Binding var isAuthenticated: Bool
    @ObservedObject var dataStore: DataStore
    var currentUserID: UUID = UUID()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                DashboardView(isAuthenticated: $isAuthenticated)
                    .navigationBarTitle("Dashboard", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Dashboard")
            }
            .tag(0)

            NavigationView {
                ChannelListView(dataStore: dataStore, searchQuery: .constant(""), currentUserID: currentUserID)
                    .navigationBarTitle("Channels", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "bubble.left.fill")
                Text("Channels")
            }
            .tag(1)
            NavigationView {
                PostingView(
                    dataStore: dataStore,
                    channelID: UUID()
                    //currentUserID: currentUserID // Pass the current user ID here
                )
                .navigationBarTitle("Post", displayMode: .inline)
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

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(isAuthenticated: .constant(true), dataStore: DataStore(), currentUserID: UUID())
    }
}

