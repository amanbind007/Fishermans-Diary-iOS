//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""

    @Environment(\.colorScheme) var colorScheme
    //@ObservedObject var fishbase = FishbaseSearch()
    @State private var scrollViewID = UUID()
    
    //@ObservedObject var pageConfig = PageConfig()
    
    @StateObject var pageConfig = PageConfig()
    @StateObject var fishbase = FishbaseSearch()

    private let adaptiveColumn = [
        GridItem()
    ]

    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumn, content: {
                        ForEach(fishbase.fishes, id: \.scientificName) { fish in
                            NavigationLink {
                                WebView(url: URL(string: fish.articleURL)!)
                                    .navigationTitle(fish.scientificName)

                            } label: {
                                FishCardView(fish: fish)
                                    .padding(.horizontal)

                            }.buttonStyle(.plain)
                        }

                        // Here I want to load more  fishes
                        if pageConfig.canLoadMore() {
                            
                            Color.clear
                                .onAppear {
                                    print("ContentView: \(pageConfig.pageNumberStart)")
                                    print("ContentView: \(pageConfig.pageNumberStop)")
                                    fishbase.getMoreFish(searchText)
                                }

                        } else {
                            
                        
                            
                            Spacer()
                            Text("No More Results")
                                .font(.headline)
                                .foregroundStyle(Color.white)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 30)
                                        .background(Material.regular)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                            Spacer()
                        }

                    })
                }
                .id(self.scrollViewID)
                .background {
                    let darkBackground = Image("DarkBackground", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .ignoresSafeArea()
                    let lightBackground = Image("LightBackground", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .ignoresSafeArea()

                    colorScheme == .dark ? darkBackground : lightBackground
                }
                .navigationTitle("Search Fish")
            }
            .searchable(text: $searchText, prompt: Text("Enter Fish Name"))
            .autocorrectionDisabled()
            .onSubmit(of: .search) {
                scrollViewID = UUID()
                fishbase.getFish(searchText)
            }
            .onAppear(perform: {
                fishbase.pageConfig = pageConfig
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
        .environment(\.colorScheme, .light)
}
