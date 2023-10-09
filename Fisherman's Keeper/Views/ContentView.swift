//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""

    var data: [String] = [
        
        "Walking catfish",
    
    ]
    private let adaptiveColumn = [
        GridItem(.flexible(minimum: 170, maximum: 175)),
        GridItem(.flexible(minimum: 170, maximum: 175)),
    ]

    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumn, content: {
                        ForEach(data, id: \.self) { _ in
                            FishCardView()
                        }
                    })
                }
                .navigationTitle("Search Fish")
            }
            .searchable(text: $searchText)
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
}
