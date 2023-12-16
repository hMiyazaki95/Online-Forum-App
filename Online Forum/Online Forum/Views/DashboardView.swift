//
//  DashboardView.swift
//  Online Forum
//
//  Created by Hajime Miyazaki on 12/6/23.
//

// DashboardView.swift
import SwiftUI

struct DashboardView: View {
    @State private var isProfilePresented = false
    @State private var isAccountPresented = false
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("Go to Profile") {
                    isProfilePresented = true
                }
                .buttonStyle(CommonButtonStyle())

                Button("Go to Account") {
                    isAccountPresented = true
                }
                .buttonStyle(CommonButtonStyle())

                Button("Log Out") {
                    isAuthenticated = false
                }
                .buttonStyle(CommonButtonStyle())

                Spacer()
            }
            .padding()
            .sheet(isPresented: $isProfilePresented) {
                ProfileView()
            }
            .sheet(isPresented: $isAccountPresented) {
                AccountView(isAuthenticated: $isAuthenticated)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(isAuthenticated: .constant(true))
    }
}

