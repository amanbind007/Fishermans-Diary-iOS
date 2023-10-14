//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = "Fish"
    
    @ObservedObject var fishbase = FishbaseSearch()
    
    
    
    
    private let adaptiveColumn = [
        GridItem(.flexible(minimum: 170, maximum: 175)),
        GridItem(.flexible(minimum: 170, maximum: 175)),
    ]

    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumn, content: {
                        ForEach(fishbase.fishes, id: \.scientificName) { _ in
                            FishCardView()
                        }
                    })
                }
                .navigationTitle("Search Fish")
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                fishbase.getFish(searchText)
            }
            .onAppear(perform: {
                fishbase.getFish(searchText)
            })
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
