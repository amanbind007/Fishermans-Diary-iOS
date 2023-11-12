//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

// This view contains the main TabView for the app
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    // Access the NetworkMonitor object from the environment.
    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        // TabView with two tabs: Search Fish and My Fish List
        TabView {
            // Search Fish View Tab
            NavigationStack {
                // Show SearchFishView if the device is connected to the
                // internet, otherwise show NoInternetCardView.
                if networkMonitor.isConnected {
                    SearchFishView()
                }
                else {
                    VStack {
                        NoInternetCardView()
                    }
                }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search Fish")
            }

            // My Fish List View Tab
            NavigationStack {
                MyFishListView()
            }
            .tabItem {
                Image(systemName: "fish")
                Text("My Fish List")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.colorScheme, .light)
}
