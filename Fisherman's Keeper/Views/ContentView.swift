//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var networkMonitor : NetworkMonitor
    var body: some View {
        TabView {
            NavigationStack {
                if networkMonitor.isConnected {
                    SearchFishView()
                }
                else{
                    VStack{
                        NoInternetCardView()
                    }
                    
                }
                
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search Fish")
            }

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
